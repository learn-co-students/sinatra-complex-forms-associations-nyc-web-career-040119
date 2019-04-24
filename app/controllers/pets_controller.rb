class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  # CREATE
  get '/pets/new' do
    # reference for selecting owner when creating a new pet
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # creates a new pet and associates an existing owner (FAILED - 7)
    @pet = Pet.create(params["pet"])
    # creates a new pet and a new owner (FAILED - 8)
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    redirect to "pets/#{@pet.id}"
  end

  # SHOW
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # UPDATE
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"/pets/edit"
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    # Update pet
    @pet.update(params["pet"])


    # Check if new owner was created, if so, set it to the new owner
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      # Requires .save method because I am setting the new owner to one thing
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end
end
