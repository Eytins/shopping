package com.zte.shopping.constant;

/**
 * Created by Eytins
 */

public interface ResponseCodeConstant {
    /**
     * 响应状态码为成功,值为:1
     */
    int RESPONSE_CODE_SUCCESS = 1;

    /**
     * 响应状态码为失败,值为:2
     */
    int RESPONSE_CODE_FAIL = 2;

    /**
     * 响应状态码为请求参数有误,值为:3
     */
    int RESPONSE_CODE_REQUEST_PARAMETER_ERROR = 3;

    /**
     * 响应状态码为登录失效,值为:4
     */
    int RESPONSE_CODE_LOGIN_TIMEOUT = 4;

    /**
     * 响应状态码为权限不足,值为:5
     */
    int RESPONSE_CODE_NO_PROMISSON = 5;
}
