package com.leoman.common.core;

/**
 * Created by Administrator on 2016/2/22.
 */
public enum ErrorType {

    ERROR_CODE_0001("系统忙，请稍后再试", 1),
    ERROR_CODE_0002("服务器异常", 2),
    ERROR_CODE_0003("找不到用户", 3),
    ERROR_CODE_0004("验证码错误", 4),
    ERROR_CODE_0005("旧密码错误", 5),
    ERROR_CODE_0006("旧密码和新密码不能一样", 6),
    ERROR_CODE_0007("地址不存在", 7),
    ERROR_CODE_0008("用户与地址不匹配", 8),
    ERROR_CODE_0009("用户已存在", 9),
    ERROR_CODE_00010("用户名或密码错误", 10),
    ERROR_CODE_00011("帖子不存在", 11),
    ERROR_CODE_00012("作品不存在", 12),
    ERROR_CODE_00013("评论不存在", 13),
    ERROR_CODE_00014("用户已签到", 14),
    ERROR_CODE_00015("主创不存在", 15),
    ERROR_CODE_00016("用户馒头数不足", 16),
    ERROR_CODE_00017("已经关注过", 17),
    ERROR_CODE_00018("暂未关注", 18),
    ERROR_CODE_00019("已经收藏过", 19),
    ERROR_CODE_00020("暂未收藏", 20),
    ERROR_CODE_00021("福利不存在", 21),
    ERROR_CODE_00022("没有互相关注，消息发送失败", 22),
    ERROR_CODE_00023("已经投票过", 23),
    ERROR_CODE_00024("中奖项不存在", 24),
    ERROR_CODE_00025("已经点赞过", 25),
    ERROR_CODE_00026("暂未点赞", 26),
    ERROR_CODE_00027("资源不存在", 27),
    ERROR_CODE_00028("验证码超时", 28),
    ERROR_CODE_00029("发车时间不能为空", 29),
    ERROR_CODE_00030("派遣班车不能为空", 30),
    ERROR_CODE_00031("路线不能为空", 31),
    ERROR_CODE_00032("该车牌号已存在", 32),
    ERROR_CODE_00033("返程时间不能为空", 33),
    ERROR_CODE_00034("该所属路线已存在1或2个，请选择其他所属路线", 34),
    ERROR_CODE_00035("该路线没有返程路线", 35),

    ErrorType;


    private String name;

    private int code;

    private ErrorType() {
    }

    private ErrorType(String name, int code) {
        this.name = name;
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }
}
