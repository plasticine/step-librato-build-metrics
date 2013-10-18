Librato Build Metrics for Wercker
==========================

Save metrics about your Wercker builds to Librato

[![wercker status](https://app.wercker.com/status/a1f85b9813897947cdeb578f949e1f10/m "wercker status")](https://app.wercker.com/project/bykey/a1f85b9813897947cdeb578f949e1f10)

***

## Usage

### Required

* `token` - Your Librato token.
* `user` - Your Librato username.

### Optional

* `namespace` - Use this option to override the default prepended namespace (`wercker.your-wercker-app-name`) for metrics when created in Librato.

## Example


    build:
        after-steps:
        - plasticine/librato-build-metrics:
            token: your-librato-token-here
            user: your-librato-username-here
            namespace: metric.namespace.etc
