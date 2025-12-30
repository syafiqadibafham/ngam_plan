enum AppRoutes {
  login('login', '/login'),
  register('register', '/register'),

  home('home', '/'),
  events('events', '/events'),
  addEvent('add-event', 'add-event'),
  editEvent('edit-event', 'edit-event'),
  settings('settings', '/settings'),
  updateProfile('update-profile', '/update-profile');

  const AppRoutes(this.name, this.path);

  final String name;
  final String path;
}
