package com.leoman.user.service.impl;

import com.leoman.common.core.Result;
import com.leoman.common.service.impl.GenericManagerImpl;
import com.leoman.entity.Constant;
import com.leoman.exception.GeneralException;
import com.leoman.exception.GeneralExceptionHandler;
import com.leoman.user.dao.UserInfoDao;
import com.leoman.user.dao.UserLoginDao;
import com.leoman.user.entity.UserInfo;
import com.leoman.user.entity.UserLogin;
import com.leoman.user.entity.WeChatUser;
import com.leoman.user.service.UserLoginService;
import com.leoman.user.service.UserService;
import com.leoman.user.service.WeChatUserService;
import com.leoman.utils.CookiesUtils;
import com.leoman.utils.Md5Util;
import com.leoman.utils.WebUtil;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2016/6/17 0017.
 */
@Service
public class UserLoginServiceImpl extends GenericManagerImpl<UserLogin, UserLoginDao> implements UserLoginService {

    @Autowired
    private UserLoginDao userLoginDao;

    @Autowired
    private UserInfoDao userInfoDao;

    @Autowired
    private UserService userService;

    @Autowired
    private WeChatUserService weChatUserService;

    @Override
    public UserInfo login(String username, String password){
        UserLogin userLogin = userLoginDao.findByUsername(username);
        if(userLogin == null){
            GeneralExceptionHandler.handle("该用户不存在");
        }

        UserLogin login = userLoginDao.findByUsernameAndPass(username,password);
        if(login == null){
            GeneralExceptionHandler.handle("用户名或密码错误");
        }

        UserInfo user = userInfoDao.findByMobile(username);
        if(user == null){
            GeneralExceptionHandler.handle("找不到该用户");
        }
        return user;
    }

    @Override
    public UserLogin findByUsername(String username) {
        return userLoginDao.findByUsername(username);
    }

    @Override
    public Result loginWeixin(HttpServletRequest request, HttpServletResponse response, String username, String password) {
        try {
//            UserInfo user = this.login(username, Md5Util.md5(password));
            Result result = new Result();

            UserLogin userLogin = userLoginDao.findByUsername(username);
            if(userLogin == null){
                result.setStatus(1);
                result.setMsg("该用户不存在");
                return result;
            }

            UserLogin login = userLoginDao.findByUsernameAndPass(username,Md5Util.md5(password));
            if(login == null){
                result.setStatus(1);
                result.setMsg("用户名或密码错误");
                return result;
            }

            UserInfo user = userInfoDao.findByMobile(username);
            if(user == null){
                result.setStatus(1);
                result.setMsg("找不到该用户");
                return result;
            }

            WeChatUser wxUser = (WeChatUser) request.getSession().getAttribute(Constant.SESSION_WEIXIN_WXUSER);

            if (null != wxUser) {
                WeChatUser wxUser1 = weChatUserService.findByOpenId(wxUser.getOpenId());
                if (null == wxUser1) {
                    weChatUserService.save(wxUser);
                }
                user.setWeChatUser(wxUser);
                userService.update(user);
            }

            request.getSession().setAttribute(Constant.SESSION_MEMBER_USER, user);

            // 登录成功后，写入cookies
            try {
                int loginMaxAge = 7 * 24 * 60 * 60; // 定义cookies的生命周期，这里是一个月。单位为秒
                CookiesUtils.addCookie(response, "username", username, loginMaxAge);
            } catch (Exception e) {
                e.printStackTrace();
                WebUtil.printJson(response,new com.leoman.common.core.bean.Result(false).msg(e.getMessage()));
            }

        } catch (Exception e) {
            e.printStackTrace();
            return Result.failure();
        }
        return Result.success();
    }

}
