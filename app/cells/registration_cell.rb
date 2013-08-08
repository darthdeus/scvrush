class RegistrationCell < Cell::Rails
  helper TournamentsHelper

  def show(args)
    @registration = TournamentRegistration.new(args[:tournament], args[:user])
    render
  end

end
