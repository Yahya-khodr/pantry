
from django.urls import path
from product.views import product_views

urlpatterns = [
    path('products/', product_views.get_products),
    path('add_product/', product_views.add_product),
    path('product/<str:barcode>/', product_views.get_product),
    path('product_by_category/<str:category>/', product_views.get_product_by_category),

    path('add_item/', product_views.add_item),
    path('get_items/', product_views.get_items),
]
