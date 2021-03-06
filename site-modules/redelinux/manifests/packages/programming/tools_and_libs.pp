class redelinux::packages::programming::tools_and_libs
{
  Package {
    ensure => installed
  }

  # Debugging / profiling
  package { 'gdb': }
  package { 'valgrind': }

  # Compiling and parsing
  package { 'javacc': }
  package { ['flex', 'bison']: }

  # Boost
  package { 'libboost-all-dev': }
  
  # QT
  package { ['qt-sdk', 'qt4-dev-tools']: }
  package { 'ruby-qt4': }
  package { ['python-qt4', 'python3-pyqt4']: }

  # WxWidgets
  package { ['wx-common', 'wx-i18n', 'wx2.8-doc', 'wx2.8-examples',
         'wx2.8-headers', 'wx2.8-i18n', 'libwxgtk2.8-dev']: }
  package { ['python-wxgtk2.8', 'python-wxtools']: }

  # GTK
  package { 'libgtk2.0-dev': }
  package { 'python-gtk2-dev': }
  package { 'libgtk2-ruby': }
  package { 'libgtk2-perl': }

  # Databases
  ## MySQL
  package { 'mysql-client': }
  package { 'libmysqlclient-dev': }
  package { 'libmysql-ruby': }
  package { 'libmysql-java': }
  package { 'python-mysqldb': }
  ## SQLite
  package { 'sqlite3': }
  package { 'libsqlite3-dev': }
  package { 'python-pysqlite2': }
  package { 'libsqlite3-ruby': }
  ## PostgreSQL
  # TODO

  # Graphics
  ## FreeGLUT
  package { 'freeglut3': }
  ## Ogre3D
  package { ['libogre-dev', 'ogre-tools']: }
  ## SDL
  package { ['libsdl1.2-dev', 'libsdl-gfx1.2-dev', 'libsdl-image1.2-dev',  
         'libsdl-mixer1.2-dev', 'libsdl-net1.2-dev', 'libsdl-sound1.2-dev',
         'libsdl-ttf2.0-dev']: }
  package { 'libsdl-ruby': }
  ## Allegro
  package { 'liballegro4.2-dev': }
  ## PyGame
  package { 'python-pygame': }

  # Source control
  ## Git
  package { ['git', 'git-man']: }
  ## Mercurial
  package { 'mercurial': }
  ## CVS
  package { 'cvs': }
  ## SVN
  package { 'subversion': }
  ## Bazaar
  package { 'bzr': }
}
