package com.leoman.city.dao;

import com.leoman.city.entity.City;
import com.leoman.common.dao.IBaseJpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by Administrator on 2016/6/12.
 */
public interface CityDao extends IBaseJpaRepository<City> {

}
