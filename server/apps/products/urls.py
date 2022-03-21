





from django.urls import path
from .views import *


urlpatterns = [
    path('product/<str:barcode>/', get_product),
    path('product_by_category/<str:category>/', get_product_by_category),
    path('add-product/', add_product)
]
