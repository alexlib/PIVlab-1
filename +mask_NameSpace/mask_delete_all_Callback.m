function mask_delete_all_Callback(~,~,~)
gui_NameSpace.gui_put('masks_in_frame',[])
delete(findobj('UserData','ROI_object_freehand'));
delete(findobj('UserData','ROI_object_rectangle'));
delete(findobj('UserData','ROI_object_circle'));
delete(findobj('UserData','ROI_object_polygon'));
delete(findobj('UserData','ROI_object_external'));
gui_NameSpace.gui_sliderdisp(gui_NameSpace.gui_retr('pivlab_axis'));
