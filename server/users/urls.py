
from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
from users.views import user_views

urlpatterns = [
    # user login, logout and registration url
    path('login/', user_views.login_view),
    path('register/', user_views.signup_view),

    # profile
    path('profile/', user_views.profile_view),
    path('update_user/', user_views.update_user),
    path('update_profile/', user_views.update_profile),
    path('update_profile_image/', user_views.update_profile_image),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
                          document_root=settings.MEDIA_ROOT)
