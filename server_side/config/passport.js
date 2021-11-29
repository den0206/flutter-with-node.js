const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const User = require('../model/user');
const dotEnv = require('dotenv');

module.exports = function (passport) {
  dotEnv.config();
  console.log(process.env.SECRET);
  let opts = {};
  opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme('jwt');
  opts.secretOrKey = process.env.SECRET;
  passport.use(
    new JwtStrategy(opts, (jwt_payload, done) => {
      User.findByPayload(jwt_payload.id, (err, user) => {
        if (err) {
          console.log(e);
          return done(err, false);
        }
        if (user) {
          console.log('Exist');
          return done(null, user);
        } else {
          console.log('NO User');
          return done(err, false);
        }
      });
    })
  );
};
