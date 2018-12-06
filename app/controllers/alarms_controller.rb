require 'rest-client'

class AlarmsController < ApplicationController
    
    def index
        @alarms = Alarm.all.reverse
    end

    def show
        @alarm = Alarm.find(params[:id])
    end
    
    def new
        @alarm = Alarm.new
    end

    def create
        @alarm = Alarm.new(alarm_params)
        @alarm.upvotes = 0
        @alarm.downvotes = 0

        if @alarm.save

            # TODO: Make an async POST 
            Thread.new do
                puts 'Async POST request'
                RestClient.post "http://bellbird.joinhandshake-internal.com/push", { 'alarm_id' => @alarm.id }.to_json, {content_type: :json, accept: :json}
            end

            redirect_to @alarm
        else
            render 'new'
        end
    end

    def add_upvote
        @alarm = Alarm.find(params[:id])
        @alarm.upvotes = @alarm.upvotes + 1;
        @alarm.save

        redirect_to alarms_path
    end

    def add_downvote
        @alarm = Alarm.find(params[:id])
        @alarm.downvotes = @alarm.downvotes + 1;
        @alarm.save

        redirect_to alarms_path
    end


    def destroy
        @alarm = Alarm.find(params[:id])
        @alarm.destroy
    
        redirect_to alarms_path
    end

    private 
        def alarm_params
            params.require(:alarm).permit(:name, :text)
        end
end
