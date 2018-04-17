// check for a passed 'username' param
params.username = null
def username
if ( params.username == null ) {
    username = System.getProperty("user.name")
} else {
    username = params.username
}

// get the system hostname to identify which system the pipeline is running from
String localhostname = java.net.InetAddress.getLocalHost().getHostName();

// create a timestamp
import java.text.SimpleDateFormat
Date now = new Date()
SimpleDateFormat timestamp_fmt = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss")
def timestamp = timestamp_fmt.format(now)

// path to the current directory
current_dir_path = new File(System.getProperty("user.dir")).getCanonicalPath()

println "[username] ${username}"
println "[localhostname] ${localhostname}"
println "[timestamp] ${timestamp}"
println "[current_dir_path] ${current_dir_path}"
