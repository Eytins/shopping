package com.zte.shopping.mapper;

import com.zte.shopping.entity.Product;
import com.zte.shopping.param.ProductParameter;

import java.util.List;

/**
 * Created by Eytins
 */

public interface IProductMapper {

    List<Product> selectAll();

    void insertProduct(Product product);

    void deleteById(int parseInt);

    Product selectById(int parseInt);

    void updateProduct(Product product);

    List<Product> selectByParamList(ProductParameter parameter);

}
