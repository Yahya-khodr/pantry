
from django.urls import path
from product.views import product_views

urlpatterns = [
    #  product endpoints
    path('products/', product_views.get_products),
    path('add_product/', product_views.add_product),
    path('product/<str:barcode>/', product_views.get_product),
    path('product_by_category/<str:category>/',
         product_views.get_product_by_category),

    # item endpoints
    path('add_item/', product_views.add_item),
    path('get_items/', product_views.get_items),
    path('remove_item/<str:item_id>/', product_views.remove_item),


    path('add_food/', product_views.add_food),
    path('get_foods/', product_views.get_foods),
    path('get_food_by_category/<str:category>/',
         product_views.get_foods_by_category),
    path('remove_food/<str:food_id>/', product_views.remove_food),
    path('increase_quantity/<str:food_id>/', product_views.increase_quantity),
    path('decrease_quantity/<str:food_id>/', product_views.decrease_quantity),



]
