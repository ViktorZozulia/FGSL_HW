module Task
use fgsl
implicit none
contains
  function GetSplineValue(x, x_array, y_array)
    real(fgsl_double), dimension(:), intent(in) :: x_array, y_array
    real(fgsl_double), intent(in) :: x
    real(fgsl_double) :: GetSplineValue
    
    integer(fgsl_int) :: status
    integer(fgsl_size_t) :: array_size
    type(fgsl_interp_accel) :: acc
    type(fgsl_spline) :: spline
    
    array_size = size(x_array,dim=1)
    acc = fgsl_interp_accel_alloc()
    spline = fgsl_spline_alloc(fgsl_interp_cspline, array_size)
    status = fgsl_spline_init (spline, x_array, y_array)
    
    GetSplineValue = fgsl_spline_eval (spline, x, acc)

    call fgsl_spline_free(spline)
    call fgsl_interp_accel_free(acc)  
    
  end function  
end module
