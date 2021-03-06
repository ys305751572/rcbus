package com.leoman.user.entity;

import com.leoman.coupon.entity.Coupon;
import com.leoman.entity.BaseEntity;

import javax.persistence.*;

/**
 * 用户拥有的优惠券
 * Created by Administrator on 2016/9/14.
 */
@Entity
@Table(name = "t_user_coupon")
public class UserCoupon extends BaseEntity{

    //用户
    @Column(name = "user_id")
    private Long userId;

    //优惠券
    @ManyToOne
    @JoinColumn(name= "coupon_id")
    private CouponOrder coupon;

    //是否使用 1:没使用 2:已使用
    @Column(name = "is_use")
    private Integer isUse;

    //使用订单
    @Column(name = "rental_id")
    private Long rentalId;


    public Integer getIsUse() {
        return isUse;
    }

    public void setIsUse(Integer isUse) {
        this.isUse = isUse;
    }

    public Long getRentalId() {
        return rentalId;
    }

    public void setRentalId(Long rentalId) {
        this.rentalId = rentalId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public CouponOrder getCoupon() {
        return coupon;
    }

    public void setCoupon(CouponOrder coupon) {
        this.coupon = coupon;
    }
}
