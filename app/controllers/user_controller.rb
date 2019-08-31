class UserController < AplicationController
before_action :authenticate_user!, only: %i[ edit ]

end
