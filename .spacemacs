;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     ;; better-defaults
     emacs-lisp
     git
     markdown
     (org :variables
          org-enable-github-support t)
     ;; spell-checking
     syntax-checking
     (version-control :variables
                      version-control-diff-tool 'git-gutter+
                      version-control-global-margin t)
     clojure
     go
     javascript
     html
     ansible
     osx
     python
     ruby
     sql
     yaml
     lua
     octave
     java
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
     evil-paredit
     evil-easymotion
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https nil
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading t
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'markdown-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(aurora
                         alect-light
   )
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ";"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'original
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native t
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'current
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (load "/Users/apesic/src/liftoff/exp/emacs/cljfmt.el")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  ; Global misc
  (setq-default fill-column 110)
  (setq whitespace-line-column fill-column)
  (setq whitespace-style '(face empty spaces tabs lines-tail trailing))
  (setq create-lockfiles nil)
  (global-whitespace-mode t)
  (setq magit-repository-directories '("~/src/"))
  (setq projectile-enable-caching t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (add-hook 'clojure-mode-hook 'evil-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)
  (add-hook 'before-save-hook 'cljfmt-before-save)
  (add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

  ; Disable macro recording
  (evil-define-key 'normal (current-global-map) (kbd "q") nil)

  ; Window motion
  (global-set-key (kbd "C-h") 'evil-window-left)
  (global-set-key (kbd "C-l") 'evil-window-right)
  (global-set-key (kbd "C-j") 'evil-window-down)
  (global-set-key (kbd "C-k") 'evil-window-up)

  (evil-define-key 'normal (current-global-map) (kbd ";") 'evil-ex)
  (global-set-key (kbd "C-;") 'execute-extended-command)

  ; Easy Motion
  ;; (evilem-default-keybindings "SPC")
  (evil-leader/set-key
    "l" 'evil-avy-goto-word-or-subword-1
    "k" 'evil-avy-goto-line)
  (evil-define-key 'normal (current-global-map) (kbd "?") 'avy-goto-char-timer)

  ; Indentation
  (evil-define-key 'normal (current-global-map) (kbd "C-.") 'evil-shift-right)
  (evil-define-key 'normal (current-global-map) (kbd "C-,") 'evil-shift-left)
  (evil-define-key 'normal (current-global-map) (kbd ">") 'evil-shift-right-line)
  (evil-define-key 'normal (current-global-map) (kbd "<") 'evil-shift-left-line)

  ; Projectile
  (evil-define-key 'normal (current-global-map) (kbd "C-f") 'helm-projectile)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy)))

  (evil-define-key 'normal (current-global-map) (kbd "TAB") 'evil-jump-item) ; Jump between parenths
  (evil-define-key 'normal (current-global-map) (kbd "SPC ,") 'evil-search-highlight-persist-remove-all)

  ; Paredit
  (evil-define-key 'normal (current-global-map) (kbd "SPC W") 'paredit-wrap-sexp)
  (evil-define-key 'normal (current-global-map) (kbd "SPC S") 'paredit-splice-sexp)

  ; Org mode
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((clojure . t)
                                 (ruby . t)))
  (require 'ob-clojure)
  (setq org-babel-clojure-backend 'cider)
  (setq org-edit-src-content-indentation 0
        org-src-tab-acts-natively t
        org-src-fontify-natively t
        org-confirm-babel-evaluate nil
        org-support-shift-select 'always)
  (setq org-hide-emphasis-markers t)
  ;; No timeout when executing calls on Cider via nrepl
  (setq org-babel-clojure-nrepl-timeout nil)

  ; HTML
  (setq web-mode-markup-indent-offset 2)
  (setq emmet-move-cursor-after-expanding t)

  ; CSS/LESS
  (setq css-indent-offset 2)

  ; Javascript
  (setq js-indent-level 2)

  ; Java
  (add-hook 'java-mode-hook (lambda ()
                              (setq c-basic-offset 2
                                    indent-tabs-mode nil)))
  (setq eclim-eclipse-dirs "/Applications/Eclipse.app/Contents/Eclipse"
        eclim-executable  "/Applications/Eclipse.app/Contents/Eclipse/eclim"
        eclimd-default-workspace "/Users/apesic/Documents/workspace")

  ; Octave
  (add-hook 'inferior-octave-mode-hook
            (lambda ()
              (turn-on-font-lock)
              (define-key inferior-octave-mode-map [up]
                'comint-previous-input)
              (define-key inferior-octave-mode-map [down]
                'comint-next-input)))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#263238" "#74CBC4" "#546D7A" "#C792EA" "#82B1FF" "#FFCB6B" "#FF516D" "#CDD3D3"])
 '(fci-rule-color "#232A2F" t)
 '(package-selected-packages
   (quote
    (wgrep smex ivy-hydra counsel-projectile counsel swiper ivy yapfify uuidgen rake py-isort pug-mode ox-gfm osx-dictionary org-projectile org-download minitest livid-mode skewer-mode simple-httpd live-py-mode link-hint jinja2-mode hide-comnt go-guru git-link eyebrowse evil-visual-mark-mode evil-unimpaired evil-ediff dumb-jump company-emacs-eclim column-enforce-mode clojure-snippets request powerline pcre2el markdown-mode js2-mode projectile git-gutter flycheck iedit tern go-mode hydra inflections multiple-cursors cider spinner clojure-mode auto-complete inf-ruby anaconda-mode company highlight anzu smartparens yasnippet helm helm-core magit magit-popup git-commit with-editor async f s dash package-build bind-key bind-map evil eclim alect-themes yaml-mode ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe use-package toc-org tagedit sql-indent spacemacs-theme spaceline smooth-scrolling smeargle slim-mode scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restart-emacs rbenv rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-yapf popwin pip-requirements persp-mode pbcopy paradox page-break-lines osx-trash orgit org-repo-todo org-present org-pomodoro org-plus-contrib org-bullets open-junk-file neotree move-text mmm-mode markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum linum-relative leuven-theme less-css-mode launchctl json-mode js2-refactor js-doc jade-mode info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio go-eldoc gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-gutter-fringe git-gutter-fringe+ gh-md flycheck-pos-tip flx-ido fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-paredit evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-easymotion evil-args evil-anzu emmet-mode elisp-slime-nav diff-hl define-word cython-mode company-web company-tern company-statistics company-quickhelp company-go company-anaconda coffee-mode clj-refactor clean-aindent-mode cider-eval-sexp-fu chruby bundler buffer-move bracketed-paste auto-yasnippet auto-highlight-symbol auto-compile aurora-theme ansible-doc ansible aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(vc-annotate-background "#2B3B40")
 '(vc-annotate-color-map
   (quote
    ((20 . "#74CBC4")
     (40 . "#74CBC4")
     (60 . "#C2E982")
     (80 . "#FFC400")
     (100 . "#C792EA")
     (120 . "#C792EA")
     (140 . "#546D7A")
     (160 . "#546D7A")
     (180 . "#FF516D")
     (200 . "#9FC59F")
     (220 . "#859900")
     (240 . "#F77669")
     (260 . "#FF516D")
     (280 . "#82B1FF")
     (300 . "#82B1FF")
     (320 . "#82B1FF")
     (340 . "#D9F5DD")
     (360 . "#FFCB6B"))))
 '(vc-annotate-very-old-color "#FFCB6B"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
