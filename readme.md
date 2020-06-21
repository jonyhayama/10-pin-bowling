# 10-pin Bowling

**Ruby Version:** 2.6.1

I was presented with this test during an interview process.

You can read the callenge description on [this file](https://github.com/jonyhayama/10-pin-bowling/blob/master/ruby-challenge-bowling_5d324cbf0656f.pdf)

## How to install

```bash
bundle install
```

## How to run

```bash
ruby application.rb --file score.tsv
```

You can point the `--file` flag to a different file if you need.

## Tests

```bash
ruby application_test.rb
```

The tests rely on the sample file, if you change it the tests will break.

## Considerations

I think the app is solid enough for an interview challenge, BUT

- I still think there is place for architecture improovements and more testing scenarios;
- I think this app should be able to print incomplete games;
- The app should highlight the winner's score;

The sample `score.tsv` file includes 5 players:

- Jeff and John are the scnearios given on the thest
- Steve is the scenario explained in [this video](https://youtu.be/aBe71sD8o8c)
- Carl is a perfect score
- Mark is a zero score
