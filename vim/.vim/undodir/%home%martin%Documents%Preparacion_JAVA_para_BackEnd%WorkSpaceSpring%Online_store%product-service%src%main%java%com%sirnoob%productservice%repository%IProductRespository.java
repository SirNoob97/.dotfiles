Vim�UnDo� œ�ȫQ8gy"� vx�S ���bz�5      .package com.sirnoob.productservice.repository;                                 _W�-    _�                            ����                                                                                                                                                                                                                                                                                                                                                             _W��     �                   5�_�                       $    ����                                                                                                                                                                                                                                                                                                                                                             _W��     �                 %public interface IProductRepository{}5�_�                       #    ����                                                                                                                                                                                                                                                                                                                                                             _W��     �             �               $public interface IProductRepository{5�_�                       :    ����                                                                                                                                                                                                                                                                                                                                                             _W��     �             �               <public interface IProductRepository extends JpaRepository<>{5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W��     �         
    �      
   	       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W��     �   
              List<>5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             _W��     �   
              List<Product>5�_�      
           	      "    ����                                                                                                                                                                                                                                                                                                                                                             _W��     �   
            #  List<Product> findByProductName()5�_�   	              
      5    ����                                                                                                                                                                                                                                                                                                                                                             _W��     �   
            5  List<Product> findByProductName(String productName)5�_�   
                 
        ����                                                                                                                                                                                                                                                                                                                                                             _W�      �   	             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W�I     �                5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�O     �               6  List<Product> findByProductName(String productName);5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�Q     �               5  List<Product findByProductName(String productName);5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�T     �                 5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�X     �                 List<>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�[     �                 List<Product>5�_�                       -    ����                                                                                                                                                                                                                                                                                                                                                             _W�     �               .  List<Product> findByMainCategoryCategoryId()5�_�                       ;    ����                                                                                                                                                                                                                                                                                                                                                             _W�     �               >  List<Product> findByMainCategoryCategoryId(Long category_id)5�_�                       =    ����                                                                                                                                                                                                                                                                                                                                                             _W�    �               =  List<Product> findByMainCategoryCategoryId(Long categoryId)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �               0  Product findByProductName(String productName);5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�#     �               4      Product findByProductName(String productName);5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�*    �               >  List<Product> findByMainCategoryCategoryId(Long categoryId);5�_�                       )    ����                                                                                                                                                                                                                                                                                                                                                             _W�V    �               E  public List<Product> findByMainCategoryCategoryId(Long categoryId);5�_�                           ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W��     �   
             5�_�                            ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W��    �   
                7  public Product findByProductName(String productName);�   
             5�_�                            ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W�	     �                 �             5�_�                            ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W�     �                5�_�                       &    ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W�     �               '  public Product findByProductBarCode()5�_�                        :    ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W�-    �               :  public Product findByProductBarCode(Long productBarCode)5�_�                              ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W�>     �                -ackage com.sirnoob.productservice.repository;5�_�                    	       ����                                                                                                                                                                                                                                                                                                                            	          	          V       _W��     �      
          M/*public interface IProductRepository extends JpaRepository<Product, Long>{*/5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             _W��     �              �                 ,(message = "The Category Name is required.")5��