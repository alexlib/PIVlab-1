function acquisition_camera_stop_Callback(~,evt,~)
gui_NameSpace.gui_put('cancel_capture',1);
acquisition_NameSpace.acquisition_control_simple_sync_serial(0,0);
%external_device_control(0);
gui_NameSpace.gui_put('laser_running',0);
gui_NameSpace.gui_put('capturing',0);
gui_NameSpace.gui_toolsavailable(1)
fresh_calib_image=gui_NameSpace.gui_retr('fresh_calib_image');
if strncmp(evt.Source.Tag,'ac_calibsave',20) %only when "save" button is pressed, then save the calibration image.
	if ~isempty(fresh_calib_image) && fresh_calib_image == 1
		gui_NameSpace.gui_put('fresh_calib_image',0);
		handles=gui_NameSpace.gui_gethand;
		projectpath=get(handles.ac_project,'String');
		numbi = 0;
		imgA_path = fullfile(projectpath, ['PIVlab_calibration' ,' (',num2str(numbi),')', '.tif']);
		while exist(imgA_path, 'file')
			numbi = numbi+1;
			imgA_path = fullfile(projectpath, ['PIVlab_calibration' ,' (',num2str(numbi),')', '.tif']);
		end
		imwrite(gui_NameSpace.gui_retr('caliimg'),imgA_path);
		set(handles.ac_calibsave,'enable','off')
	end
	drawnow;
end
