# TwitterClientSample-iOS
Base of Twitter client withTwitterKit, swift language.

## Set up

```AppDelegate.swift
TWTRTwitter.sharedInstance().start(withConsumerKey: "{YOUR CONSUMER KEY}",
                                   consumerSecret: "{YOUR CONSUMER KEY SECRET}")
```

```Info.plist
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
                <string>twitterkit-{YOURCONSUMERKEY}</string>
			</array>
		</dict>
	</array>

```

## 参考資料

- [https://o-tyazuke.hatenablog.com/entry/2016/11/23/123748](https://o-tyazuke.hatenablog.com/entry/2016/11/23/123748)
