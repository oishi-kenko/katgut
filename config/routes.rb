Katgut::Engine.routes.draw do
  get '/:id', to: 'rules#show', as: :rule
end
