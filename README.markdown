ActiveSMS: SMSGlobal
====================

ActiveSMS connector for this Australian SMS gateway: SMSGlobal http://www.smsglobal.com/ (Yes, I know the name is backwards)

I just drop this in the Rails lib directory, but there is probably somewhere better (Like submitting it upstream :P)

Usage:
------

Put this in an environment or initializer:

    ActiveSms::Base.establish_connection(
        :adapter => 'global_sms',
        :user => '[username]',
        :password => '[password]'
    )

TODO
----

Some tests
