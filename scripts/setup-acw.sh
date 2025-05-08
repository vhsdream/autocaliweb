#!/bin/bash

# Make required directories and files for metadata enforcement
make_dirs () {
    install -d -o abc -g abc /app/autocaliweb/metadata_change_logs
    install -d -o abc -g abc /app/autocaliweb/metadata_temp
    install -d -o abc -g abc /acw-book-ingest
    install -d -o abc -g abc /calibre-library
}

# Change ownership & permissions as required
change_script_permissions () {
    chmod +x /etc/s6-overlay/s6-rc.d/acw-auto-library/run
    chmod +x /etc/s6-overlay/s6-rc.d/acw-auto-zipper/run
    chmod +x /etc/s6-overlay/s6-rc.d/acw-ingest-service/run
    chmod +x /etc/s6-overlay/s6-rc.d/acw-init/run
    chmod +x /etc/s6-overlay/s6-rc.d/metadata-change-detector/run
    chmod +x /etc/s6-overlay/s6-rc.d/universal-calibre-setup/run
    chmod +x /etc/s6-overlay/s6-rc.d/init-*/run
    chmod 775 /app/autocaliweb/cps/editbooks.py
    chmod 775 /app/autocaliweb/cps/admin.py
    chmod 755 /docker-mods
}

# Add aliases to .bashrc
add_aliases () {
    cat <<- 'EOF' >> ~/.bashrc

    # Autocaliweb Aliases
    alias acw-check='bash /app/autocaliweb/scripts/check-acw-services.sh'
    alias acw-change-dirs='nano /app/autocaliweb/dirs.json'
    cover-enforcer () {
        python3 /app/autocaliweb/scripts/cover_enforcer.py "$@"
    }
    convert-library () {
        python3 /app/autocaliweb/scripts/convert_library.py "$@"
    }
EOF

    source ~/.bashrc
}

echo "Running docker image setup script..."
make_dirs
change_script_permissions
add_aliases