start:
	@echo "Running WebApplizer Development Mode"
	@bundle exec thin start -p 3000

package:
	@echo "Building / Compressing Application"
	@ruby make_assets.rb
