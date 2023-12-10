require 'pagy/extras/bootstrap'
require 'pagy/extras/countless'

Pagy::DEFAULT[:page] = 1
Pagy::DEFAULT[:items] = 6
Pagy::DEFAULT[:outset] = 0 
Pagy::DEFAULT[:overflow] = :empty_page