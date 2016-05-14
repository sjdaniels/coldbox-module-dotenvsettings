ColdBox DotEnvSettings Module
==============================
This module reads a .env (or other file containing secrets) and loads the values into the parent app's ColdBox settings.

##LICENSE
Apache License, Version 2.0.

##SYSTEM REQUIREMENTS
- Railo/Lucee 4+
- ColdFusion 9+
- ColdBox 4+

---

#Instructions
Just drop into your `modules` folder or use the box-cli to install

`box install dotenvsettings`

##USAGE
Create a .env file in your project root and add to .gitignore or your version control's equivalent (don't commit secrets to your repo!) The file can contain JSON or Java properties style key value pairs:


```js
// property style
MY_SECRET_KEY=somevalue
MY_OTHER_SECRET=shh

// json style
{
     MY_SECRET_KEY="somevalue"
    ,MY_OTHER_SECRET="shh"
};
```

In your ColdBox app you can access these with `getSetting("MY_SECRET_KEY")` or DI with `property name="mykey" inject="coldbox:setting:MY_SECRET_KEY";`

If you want to customize your secrets file name / location just add the following struct to your `Coldbox.cfc` `config()` method:

```js
dotenv = {
    fileName = "config/secrets.json"
}
```