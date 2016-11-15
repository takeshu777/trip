#unicornのpidファイル、設定ファイルのディレクトリを指定
namespace :nginx do

	#ngixを停止させるtask
	  desc "Stop ngix server"
	  task stop: :environment do
	    on roles(:app) do
	    	execute :serivice, :nginx, :stop
	    end
	  end

	#ngixを起動させるtask
	  desc "Stop ngix server"
	  task stop: :environment do
	    on roles(:app) do
	    	execute :serivice, :nginx, :stop
	    end
	  end

end