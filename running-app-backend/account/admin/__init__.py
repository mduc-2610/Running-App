from django.contrib import admin

from .performance import PerformanceAdmin
from .privacy import PrivacyAdmin
from .profile import ProfileAdmin
from .user import UserAdmin
from .notfication_setting import NotificationSettingAdmin
                    # UserTabularInline
from account.models import Performance, \
                            Privacy, \
                            Profile, \
                            User, \
                            NotificationSetting

admin.site.register(Performance, PerformanceAdmin)
admin.site.register(Privacy, PrivacyAdmin)
admin.site.register(Profile, ProfileAdmin)
admin.site.register(User, UserAdmin)
admin.site.register(NotificationSetting, NotificationSettingAdmin)

