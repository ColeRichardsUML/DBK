function DBK_proc_start {
    param(
        
    )

    DBK_dt_writer -wd "DBK_proc_start has been called."

    if (DBK_proc_is_running) {
        DBK_dt_writer -wh ($config.process.exe + " is running.")
    } else {
        DBK_dt_writer -wh ("Starting " + $config.process.exe + "...")
        Start-Process -FilePath $config.process.exe -WorkingDirectory $config.process.path
    }

    # return DBK_proc_is_running

}
