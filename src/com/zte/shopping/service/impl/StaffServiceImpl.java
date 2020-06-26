package com.zte.shopping.service.impl;

import com.zte.shopping.constant.DictConstant;
import com.zte.shopping.constant.StatusConstant;
import com.zte.shopping.dao.IStaffDao;
import com.zte.shopping.entity.Dept;
import com.zte.shopping.entity.Staff;
import com.zte.shopping.exception.*;
import com.zte.shopping.service.IStaffService;
import com.zte.shopping.util.DataUtil;
import com.zte.shopping.util.MD5Util;
import com.zte.shopping.util.ParameterUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created by Eytins
 */


@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class StaffServiceImpl implements IStaffService
{
    @Autowired
    private IStaffDao staffDao;


    /**
     * 管理员 登录  方法
     *
     * @throws CodeErrorException 验证码错误   自定义异常
     * @throws SatffNotExistException 后台管理员不存在    自定义异常
     */
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Staff login(String loginName, String password, String code, HttpSession session, String role) throws CodeErrorException, SatffNotExistException
    {
        // 管理员输入的验证码错误
        String image = (String) session.getAttribute("code");
        if (!code.equals(image))
        {
            throw new CodeErrorException("验证码不正确");
        }

        // StatusConstant.STAFF_IS_VALID_ENABLE 员工状态是否有效,有效,值为:1
        // 密码要用MD5加密
        System.out.println("0000000000000000000000000000000:" + MD5Util.md5(password));
        Staff staff = staffDao.selectByLoginNameAndPassword(loginName, MD5Util.md5(password), StatusConstant.STAFF_IS_VALID_ENABLE,Integer.parseInt(role));
        if (staff == null)
        {
            throw new SatffNotExistException("账号或密码错误");
        }

        System.out.println("============================================" + staff);

        return staff;
    }


    @Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
    public List<Staff> findFuzzyByParamList(Staff staffParameter, String deptId)
    {
        Staff staff = new Staff();
        staff.setStaffName(DataUtil.stringSpace(staffParameter.getStaffName()));
        staff.setLoginName(DataUtil.stringSpace(staffParameter.getLoginName()));
        staff.setPhone(DataUtil.stringSpace(staffParameter.getPhone()));
        staff.setEmail(DataUtil.stringSpace(staffParameter.getEmail()));


        if (!(ParameterUtil.isnull(deptId)) && !("-1".equals(deptId)))
        {
            Dept dept = new Dept();
            dept.setDeptId(Integer.parseInt(deptId));
            staff.setDept(dept);
        }




        staff.setRole(staffParameter.getRole());


        staff.setIsValid(staffParameter.getIsValid());

        List<Staff> staffList = staffDao.selectFuzzyByParams(staff);

        return staffList;
    }


    /**
     * 添加管理员
     *
     * 员工账号不能重复
     * 密码需要使用MD5加密
     * 创建人      为    当前登录员工
     * 创建时间   为   当前时间
     * 默认  创建的员工  为  有效   状态
     */
    public void addStaff(Staff staff, String deptId, HttpSession session) throws LoginDisabledException, NoPromissionException, StaffExistException
    {
        // 获取当前登录的员工
        Staff currentStaff = (Staff)session.getAttribute("staff");

        if (currentStaff == null)
        {
            throw new LoginDisabledException("登录失败,请重新登录");
        }

        if (!DictConstant.STAFF_ROLE_PREMISSION_SYSTEM_MANAGER.equals(currentStaff.getRole()))
        {
            throw new NoPromissionException("权限不足,您不是系统管理员");
        }

        // 根据账号查询员工信息
        Staff selectStaff = staffDao.selectByLoginName(staff.getLoginName());
        // 判断该管理员账号   是否已经存在
        if (selectStaff != null)
        {
            throw new StaffExistException("该管理员账号已经存在");
        }

        // 设置员工所在部门
        Dept dept = new Dept();
        dept.setDeptId(Integer.parseInt(deptId));

        staff.setDept(dept);

        // 对密码进行加密
        staff.setPassword(MD5Util.md5(staff.getPassword()));

        // 创建的员工  为  有效   状态
        staff.setIsValid(StatusConstant.STAFF_IS_VALID_ENABLE);

        // 创建时间为当前时间
        staff.setCreateDate(new Date());

        // 创建人为当前登录员工
        staff.setCreateStaff(currentStaff);

        // 添加管理员
        staffDao.insertStaff(staff);
    }


    /**
     * 做修改管理员操作时  查询出修改页面的管理员信息
     */
    @Override
    public Staff findById(String staffId) throws RequestParameterException
    {
        if (ParameterUtil.isnull(staffId))
        {
            throw new RequestParameterException("管理员id不能为空");
        }

        Staff staff = staffDao.selectById(Integer.parseInt(staffId));

        return staff;
    }

    /**
     * 修改管理员
     */
    @Override
    public void modifyStaff(Staff staff, String deptId) throws RequestParameterException
    {
        if (ParameterUtil.isnull(staff.getStaffName()))
        {
            throw new RequestParameterException("管理员姓名不能为空!");
        }

        Dept dept = new Dept();
        dept.setDeptId(Integer.parseInt(deptId));

        staff.setDept(dept);

        staffDao.updateStaff(staff);
    }

    /**
     * 管理员 启用/禁用
     */
    public void modifyStaffStatus(String staffId, String isValid) throws RequestParameterException
    {
        if (ParameterUtil.isnull(staffId))
        {
            throw new RequestParameterException("管理员id不能为空");
        }

        if (ParameterUtil.isnull(isValid))
        {
            throw new RequestParameterException("管理员状态不能为空");
        }

        Integer staffStatus = Integer.parseInt(isValid);

        if (staffStatus == StatusConstant.STAFF_IS_VALID_DISABLE)
        {
            staffStatus = StatusConstant.STAFF_IS_VALID_ENABLE;
        }else
        {
            staffStatus =  StatusConstant.STAFF_IS_VALID_DISABLE;
        }

        staffDao.updateStaffStatus(Integer.parseInt(staffId), staffStatus);
    }

}
