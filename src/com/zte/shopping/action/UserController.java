package com.zte.shopping.action;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zte.shopping.constant.DictConstant;
import com.zte.shopping.constant.ResponseCodeConstant;
import com.zte.shopping.entity.User;
import com.zte.shopping.exception.RequestParameterException;
import com.zte.shopping.exception.UserExistException;
import com.zte.shopping.service.IUserService;
import com.zte.shopping.util.ParameterUtil;
import com.zte.shopping.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by Eytins
 */

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private IUserService iUserService;

    @RequestMapping(value = "ShowMain")
    public String showMain() {
        return "main";
    }

    /**
     * 会员组合条件查询(动态查询)
     * 根据前台页面所传递的参数选择合适的条件进行查询
     * 支持模糊查询
     */
    @RequestMapping("/findByFuzzyParamList")
    public ModelAndView findByFuzzyParamList(String pageNo, String pageSize, User userParam) {
        ModelAndView modelAndView = new ModelAndView();

        if (ParameterUtil.isnull(pageNo)) {
            pageNo = DictConstant.PAGE_NO;
        }

        if (ParameterUtil.isnull(pageSize)) {
            pageSize = DictConstant.PAGE_SIZE;
        }


        PageHelper.startPage(Integer.parseInt(pageNo), Integer.parseInt(pageSize));

        List<User> userList = iUserService.findByFuzzyParamList(userParam);

        PageInfo<User> pageUserList = new PageInfo<User>(userList);

        modelAndView.addObject("pageUserList", pageUserList);

        modelAndView.addObject("userParam", userParam);

        modelAndView.setViewName("backend/userManager");

        return modelAndView;
    }

    /**
     * 启用/禁用
     * 根据 会员id  修改对应  会员的状态
     */
    @ResponseBody
    @RequestMapping("/modifyStatus")
    public ResponseResult modifyStatus(String id, String status) {
        ResponseResult result = new ResponseResult();

        try {
            iUserService.modifyStatus(id, status);

            result.setMessage("成功");
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_SUCCESS);

        } catch (RequestParameterException e) {
            result.setMessage(e.getMessage());
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_REQUEST_PARAMETER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            result.setMessage("服务器内部异常");
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_FAIL);
        }

        return result;
    }

    /**
     * 修改会员信息页面的默认值
     */
    @ResponseBody
    @RequestMapping("/findById")
    public ResponseResult findById(String id) {
        ResponseResult result = new ResponseResult();

        try {
            User user = iUserService.findById(id);

            result.setMessage("成功");
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_SUCCESS);
            result.setReturnObject(user);

        } catch (RequestParameterException e) {
            result.setMessage(e.getMessage());
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_REQUEST_PARAMETER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            result.setMessage("服务器内部异常");
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_FAIL);
        }

        return result;
    }

    /**
     * 根据  会员id  修改会员信息
     * <p>
     * 账号不能重复
     */
    @ResponseBody
    @RequestMapping("/modifyById")
    public ResponseResult modifyById(User user) {
        ResponseResult result = new ResponseResult();

        try {
            iUserService.modifyById(user);

            result.setMessage("成功");
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_SUCCESS);

        } catch (UserExistException e) {
            result.setMessage(e.getMessage());
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_FAIL);
        } catch (Exception e) {
            e.printStackTrace();
            result.setMessage("服务器内部异常");
            result.setResponseCode(ResponseCodeConstant.RESPONSE_CODE_FAIL);
        }

        return result;
    }

}
