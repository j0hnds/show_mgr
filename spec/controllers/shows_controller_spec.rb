require 'spec_helper'

describe ShowsController do

  context 'Filters' do

    it "should not invoke the filter when the index method is called" do
      mock_show = mock_model Show
      Show.should_not_receive(:where)
      Show.should_receive(:order).with("start_date DESC").and_return([ mock_show ])

      get :index, format: 'json'

      expect(response.status).to eq(200)
      expect(assigns[:shows]).to eq( [ mock_show ])
    end

    it "should return a 404 if the id param does not refer to an existing show" do
      Show.should_receive(:where).with(id: '1').and_return([])

      get :show, id: 1 #, format: 'json'
      
      expect(response.status).to eq(404)
    end

  end

  context 'Actions' do

    context '#index' do

      it "should return the list of all shows ordered by start_date" do
        mock_show = mock_model Show
        Show.should_receive(:order).with("start_date DESC").and_return([ mock_show ])
        get :index, format: 'json'

        expect(response.status).to eq(200)
        expect(assigns[:shows]).to eq( [ mock_show ])
      end

    end

    context '#show' do

      it "should return the show for the specified id" do
        mock_show = mock_model Show
        id = mock_show.id

        Show.should_receive(:where).with(id: id.to_s).and_return([ mock_show ])
        get :show, id: id, format: 'json'

        expect(response.status).to eq(200)
        expect(assigns[:show]).to eq( mock_show )
      end

    end

  end

end
