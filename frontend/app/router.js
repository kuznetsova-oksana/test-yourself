import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('quizzes');
  this.route('profile');
  this.route('questions');
  this.route('userProfile');

  this.route('quiz',{ path: '/quizzes/:quiz_id'});
  this.route('category',{ path: '/category/:category_id'});
});

Router.reopen({
  location: 'hash'
});

export default Router;
