class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets' do
    @pet = Pet.create(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.find_or_create_by(params["owner"])
    end
    @pet.owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"pets/edit"
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.find_or_create_by(params["owner"])
    end
    @pet.owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end
end
