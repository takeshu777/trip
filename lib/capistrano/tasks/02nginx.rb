namespace :nginx do

	#ngixを停止させるtask
	  desc "Stop ngix server"
	  task stop: :environment do
	    on roles(:app) do
	    	execute :serivice, :nginx, :stop
	    end
	  end

	#ngixを起動させるtask
	  desc "Start ngix server"
	  task start: :environment do
	    on roles(:app) do
	    	execute :serivice, :nginx, :start
	    end
	  end

end