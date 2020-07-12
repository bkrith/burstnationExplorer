

let bgGlobeColors = [
    'ac725e',
    'd06b64',
    'ffad46',
    '16a765',
    '7bd148',
    'b3dc6c',
    '88e974',
    'fad165',
    '92e1c0',
    '9f8187',
    '9fc6e7',
    '4986e7',
    '9a9cff',
    'b99aff',
    'c2c2c2',
    'cabdbf',
    'cca6ac',
    'f691b2',
    'cd74e6',
    '947a82',
    'ac725e',
    'd06b64',
    '16a765',
    '7bd148',
    'b3dc6c',
    '88e974',
    '92e1c0',
    '9f8187',
    '9fc6e7',
    '4986e7',
    '9a9cff',
    'b99aff',
    'c2c2c2',
    'cabdbf',
    'cca6ac',
    'cd74e6',
    '947a82',
    'ac725e',
    'd06b64',
    'ffad46',
    '16a765',
    '7bd148',
    'b3dc6c',
    '88e974',
    'fad165',
    '92e1c0',
    '9f8187',
    '9fc6e7',
    '4986e7',
    '9a9cff',
    'b99aff',
    'c2c2c2',
    'cabdbf',
    'cca6ac',
    'f691b2',
    'cd74e6',
    '947a82',
    'ac725e',
    'd06b64',
    '16a765',
    '7bd148',
    'b3dc6c',
    '88e974',
    '92e1c0',
    '9f8187',
    '9fc6e7',
    '4986e7',
    '9a9cff',
    'b99aff',
    'c2c2c2',
    'cabdbf',
    'cca6ac',
    'cd74e6',
    '947a82'
];

    let container = document.getElementById('globe');

    let createLoader = (function () {

        let progress = null;
        let finished = false;

        let canvas = null;
        let callback = null;

        function setupLoaderElement() {
            container = document.getElementById('globe');
        }

        function setupCanvas() {
            canvas.style.transition = 'opacity 1s';
            canvas.style.opacity = '0';
        }

        function showCanvas() {
            container.appendChild(canvas);
            if (typeof callback === 'function') {
                callback();
            }
            setTimeout(function () {
                canvas.style.opacity = '1';
            }, 0);
        }

        return function (_canvas, _callback) {
            let manager = new THREE.LoadingManager();

            canvas = _canvas;
            callback = _callback;

            setupLoaderElement();
            setupCanvas();

            manager.onProgress = function (item, loaded, total) {
                showCanvas();
            };

            return manager;
        }

    })();
    // ------ Marker object ------------------------------------------------

    function Marker(active, arrayColor, lngth) {
        THREE.Object3D.call(this);

        let radius = 0.005;
        let sphereRadius = 0.02;
        let height = 0.25 * parseInt(lngth); 
        let width = 0.005;
        let depth = 0.005;
        let color = parseInt(arrayColor, 16);

        if (active != 1) {
            height = 0.05;
            color = 0xff0000;
        }

        let material = new THREE.MeshPhongMaterial({ color: color, opacity: 1, transparent: false });

        let cube = new THREE.Mesh(new THREE.CubeGeometry(width, height, depth), material);
        cube.position.y = height * 0.5;
        cube.rotation.x = Math.PI;

        this.add(cube);
    }

    Marker.prototype = Object.create(THREE.Object3D.prototype);

    // ------ Earth object -------------------------------------------------

    function Earth(radius, texture) {
        THREE.Object3D.call(this);

        this.userData.radius = radius;

        let earth = new THREE.Mesh(
            new THREE.SphereBufferGeometry(radius, 64.0, 48.0),
            new THREE.MeshPhongMaterial({
                color: 0xffffff,
                map: texture
            })
        );

        this.add(earth);
    }

    Earth.prototype = Object.create(THREE.Object3D.prototype);

    Earth.prototype.createMarker = function (lon, lat, lngth, active, arrayColor) {
        let marker = new Marker(active, arrayColor, lngth);

        let lonRad = lon * (Math.PI / 180);
        let latRad = -lat * (Math.PI / 180);
        let r = this.userData.radius;

        marker.position.set(Math.cos(lonRad) * Math.cos(latRad) * r, Math.sin(lonRad) * r, Math.cos(lonRad) * Math.sin(latRad) * r);
        marker.rotation.set(0.0, -latRad, lonRad - Math.PI * 0.5);

        this.add(marker);
    };

    // ------ Three.js code ------------------------------------------------

    let scene, camera, renderer;
    let controls;

    function init() {
        scene = new THREE.Scene();

        camera = new THREE.PerspectiveCamera(45, 4 / 3, 0.1, 100);
        camera.position.set(0.0, 1.5, 5.0);
        scene.add(camera);

        renderer = new THREE.WebGLRenderer({ antialias: false, alpha:true });

        controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.autoRotate = true;
        controls.autoRotateSpeed = -1.0;
        controls.enablePan = false;

        let ambient = new THREE.AmbientLight(0xffffff, 0.7);
        scene.add(ambient);

        let direcitonal = new THREE.DirectionalLight(0xffffff, 0.7);
        direcitonal.position.set(5.0, 2.0, 5.0).normalize();
        camera.add(direcitonal);

        // just some code for the loading
        let manager = createLoader(renderer.domElement, animate);

        let texLoader = new THREE.TextureLoader(manager).setCrossOrigin(true);

        let texture = texLoader.load('ui/images/earth3.jpg');
        texture.anisotropy = renderer.capabilities.getMaxAnisotropy();

        let earth = new Earth(1.5, texture);

        $.get('api/peers/globe', function(data) {
            let res = JSON.parse(data);
            let countries = res['countries'];
            let peers = res['peers'];
            for (let i = 0 ; i < peers.length - 1 ; i++) {
                if (peers[i][3]) {
                    let colorIndex = countries.indexOf(peers[i][3]);
                    let color = 'ffffff';
                    try {
                        color = bgGlobeColors[colorIndex - (parseInt(colorIndex / 78) * 78)];
                    }
                    catch (e) {}

                    earth.createMarker(peers[i][1], peers[i][0], peers[i][4], peers[i][2], color);
                }
            }

            scene.add(earth);

            let spriteMaterial = new THREE.SpriteMaterial({ 
                map: texLoader.load( 'ui/images/glow.png' ),
                color: 0xffffff, transparent: false, blending: THREE.AdditiveBlending
            });

            let sprite = new THREE.Sprite( spriteMaterial );
            sprite.scale.set(3.3, 3.3, 1.5);
            earth.add(sprite); 

            window.addEventListener('resize', onResize);
            onResize();

            container.appendChild(renderer.domElement);
        });
    }

    function onResize() {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();

        renderer.setSize(window.innerWidth, window.innerHeight);
    }

    function animate() {
        requestAnimationFrame(animate);

        controls.update();

        renderer.render(scene, camera)
    }