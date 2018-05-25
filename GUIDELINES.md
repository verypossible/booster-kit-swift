While  has their [own list](https://developer.apple.com/app-store/review/rejections/) we've found some other common issue or unforeseen issues that may hinder [getting ready for an  app submission](https://developer.apple.com/app-store/review/guidelines/):

# General
1. App reviewers are individuals and prone to subjective interpretation of the guidelines.
2. Allow at minimum 1 week for app approval. Try submitting early and then pushing updates with am expedited review.
3. It is against the rules to sell the app or app features outside of 's payment system. Be careful because linking outside of the app may put you in real or perceived violation of this.
4. All apps must work within an IPv6 only network. In practice this will work with most HTTP clients and a service with a domain name but be careful to avoid IPv4 address when possible.
5. Passwordless authentication (email with universal link to app) is difficult for app reviewers to understand. Take care before implementing.
6. If your app makes HTTPS calls then in the Export Compliance section of the app submission you must mark that you use encryption, however you [will not be required to provide documentation to iTunesConnect](https://help.apple.com/itunes-connect/developer/#/devc3f64248f)
7. It is easier to setup a dummy account and provide those credentials to  than to argue with their reviewers.

# IoT
1. Submit as early as possible.
2. Try submitting with a video of the app working rather than shipping a companion device.
3. Instructions for shipping device to :

>To send us any hardware or accessories, please:
>1. Label the hardware with the app name "APP_NAME" and the App ID "ID_NUMBER".
>2. Then send it to:
>   >Apple, Inc.
>   >One Apple Park Way, M/S: 124-2APP
>   >Cupertino, CA 95014
>   >USA
>   >ATTN: Marcus East
>
>  3. If your hardware is MFi, include the PPID# in the Review Notes when you submit your app.
>  4. Provide shipping information and tracking confirmation numbers in the Review Notes.
>  5. Include any required demo account information, including passwords, in the Demo Account and Password section of your iTunes Connect App Information.
