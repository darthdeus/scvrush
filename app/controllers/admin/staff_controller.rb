module Admin
  class StaffController < AdminController

    def index
      @data = [
        {
          category: "Lead staff",
          people: [
            {
              name: "Jakub Arnold",
              avatar: "http://placehold.it/100",
              attributes: [
                [ "skype", "darthslayer" ],
                [ "intelligence", "monstrously magnificently glorious" ]
              ]
            }
          ]
        }
      ].to_json
    end

  end
end
