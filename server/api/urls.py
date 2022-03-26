
from django.urls import path
from api.views import user_views

urlpatterns = [
    # user login, logout and registration url
    path('login/', user_views.login_view),
    path('register/', user_views.signup_view),

    # profile 
    path('profile/', user_views.profile_view),
    path('update_user/', user_views.update_user)
]
