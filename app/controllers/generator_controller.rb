class GeneratorController < ApplicationController
    def index
        @palette =  if params[:hex_value]
                        params[:hex_value].paint.palette.send(params[:palette_type])
                    else
                        nil
                    end
        # require 'pry'; binding.pry
    end
end