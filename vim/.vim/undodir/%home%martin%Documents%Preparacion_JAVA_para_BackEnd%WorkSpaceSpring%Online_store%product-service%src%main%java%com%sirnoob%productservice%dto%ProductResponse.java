Vim�UnDo� /-v�/�� 5,�\���"���/)�4�L                    <       <   <   <    _n!    _�                             ����                                                                                                                                                                                                                                                                                                                                                             _W��     �                   5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W��    �                 public class ProductResponse{}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W�     �               �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                }5�_�                    $       ����                                                                                                                                                                                                                                                                                                                                                             _W�     �   $                �   $            5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                E  @Column(name = "product_bar_code", nullable = false, unique = true)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                N  @Column(name = "product_name", nullable = false, unique = true, length = 30)5�_�      	              
       ����                                                                                                                                                                                                                                                                                                                                                             _W�     �   	   
            @Lob5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                3  @Column(name = "product_stock", nullable = false)5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                3  @Column(name = "product_price", nullable = false)5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                  @Column(name = "create_at")5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                "  @Column(name = "product_status")5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                #  @ManyToOne(fetch =FetchType.LAZY)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                #  @JoinColumn(name = "category_id")5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                  @ManyToMany5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                /  @JoinTable(name = "sub_categories_products", 5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                B              joinColumns = { @JoinColumn(name = "fk_product") }, 5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�     �                M              inverseJoinColumns = { @JoinColumn(name = "fk_sub_category") })5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             _W�3     �      	       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W�9     �                    �                5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W�<    �   	      &    �   
      $    �         "    �             �                5�_�                    $       ����                                                                                                                                                                                                                                                                                                                                                             _Wɳ     �   #   %   '      $  private MainCategory mainCategory;5�_�                    $       ����                                                                                                                                                                                                                                                                                                                                                             _Wɹ     �   #   %   '        private String mainCategory;5�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             _Wɿ    �   %   '   '      )  private Set<SubCategory> subCategories;5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W��     �                6import com.sirnoob.productservice.entity.MainCategory;   5import com.sirnoob.productservice.entity.SubCategory;    5�_�                          ����                                                                                                                                                                                                                                                                                                                                                             _W�G     �         $        private Long productId;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _W�H     �         %        private Long productId;     �         %          5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             _W�I     �         $        private Long productBarCode;    �         $       5�_�      !                       ����                                                                                                                                                                                                                                                                                                                                                             _W�J     �         #        private String productName;    �         #       5�_�       "           !          ����                                                                                                                                                                                                                                                                                                                                                             _W�K     �         "        5�_�   !   #           "           ����                                                                                                                                                                                                                                                                                                                                                             _W�L     �         "      $  private String productDescription;    �         "       5�_�   "   $           #          ����                                                                                                                                                                                                                                                                                                                                                             _W�L     �         !        private Integer productStock;    �         !        5�_�   #   %           $          ����                                                                                                                                                                                                                                                                                                                                                             _W�M     �                  private Double productPrice;5�_�   $   &           %           ����                                                                                                                                                                                                                                                                                                                                                             _W�O     �                  private Double productPrice;    �                 5�_�   %   '           &           ����                                                                                                                                                                                                                                                                                                                                                             _W�P     �                 private LocalDate createAt;    �                5�_�   &   (           '          ����                                                                                                                                                                                                                                                                                                                                                             _W�P     �                5�_�   '   )           (           ����                                                                                                                                                                                                                                                                                                                                                             _W�Q     �                 private String productStatus;    �                5�_�   (   *           )           ����                                                                                                                                                                                                                                                                                                                                                             _W�R    �               "  private String mainCategoryName;    �                5�_�   )   +           *          ����                                                                                                                                                                                                                                                                                                                                                             _Y�     �               $  private Set<String> subCategories;5�_�   *   .           +          ����                                                                                                                                                                                                                                                                                                                                                             _Y�    �             �               "  private String mainCategoryName;5�_�   +   /   ,       .      
    ����                                                                                                                                                                                                                                                                                                                                                             _Y �     �               (  private MainCategory mainCategoryName;5�_�   .   0           /      
    ����                                                                                                                                                                                                                                                                                                                                                             _Y �     �                 private mainCategoryName;5�_�   /   1           0          ����                                                                                                                                                                                                                                                                                                                                                             _Y �     �               1  private Set<SubCategoryResponse> subCategories;5�_�   0   2           1          ����                                                                                                                                                                                                                                                                                                                                                             _Y �     �               !  private Set<Sub> subCategories;5�_�   1   3           2          ����                                                                                                                                                                                                                                                                                                                                                             _Y �    �                 private Set<S> subCategories;5�_�   2   4           3           ����                                                                                                                                                                                                                                                                                                                                                             _Y �    �                6import com.sirnoob.productservice.entity.MainCategory;    5�_�   3   5           4           ����                                                                                                                                                                                                                                                                                                                                                             _\�s     �                 5�_�   4   6           5          ����                                                                                                                                                                                                                                                                                                                                                             _\�u   	 �                 private Long productId;  5�_�   5   7           6           ����                                                                                                                                                                                                                                                                                                                                                             _m�     �                 �             5�_�   6   8           7          ����                                                                                                                                                                                                                                                                                                                                                             _m�   
 �                $  private Set<String> subCategories;5�_�   7   9           8           ����                                                                                                                                                                                                                                                                                                                                                             _m�     �                import java.util.Set;5�_�   8   :           9           ����                                                                                                                                                                                                                                                                                                                                                             _m��     �                 5�_�   9   <           :           ����                                                                                                                                                                                                                                                                                                                                                             _m��    �             5�_�   :       ;       <   	        ����                                                                                                                                                                                                                                                                                                                                                             _n     �      	           5�_�   :           <   ;           ����                                                                                                                                                                                                                                                                                                                                                             _n
     �             �               import lombok.Getter;5�_�   +   -       .   ,          ����                                                                                                                                                                                                                                                                                                                                                             _Y �     �                 private MaimainCategoryName;5�_�   ,               -      
    ����                                                                                                                                                                                                                                                                                                                                                             _Y �     �                 private ;5�_�                          ����                                                                                                                                                                                                                                                                                                                                                             _W��     �              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _W��     �              5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             _W��     �              5��