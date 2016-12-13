# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) : section has many videos
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) : a video belongs to a section
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) : video has many ratings through videoratings
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) : the note content on a rating
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) : presence and uniqueness in user, section, video models.
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes): videos/all_hardest_videos
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item) video form with new section by name (section= is the custom attribute writer.)
- [x] Include signup (how e.g. Devise) : used devise
- [x] Include login (how e.g. Devise) : used devise
- [x] Include logout (how e.g. Devise) : used devise
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) : used omniauth, devise, and figaro to support github authentication
- [x] Include nested resource show or index (URL e.g. users/2/recipes) : videos/:id/ratings (index)
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients) : /videos/:id/ratings/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new) : errors partial, as well as displays flash errors on layout

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
