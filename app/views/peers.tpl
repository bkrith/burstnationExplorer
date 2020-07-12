
<div class="tableDiv">
    <div id="globe"></div>
</div>
<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table mainTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="7">
                    <div class="tbHeaderDiv floatLeft">
                        <i class="material-icons">location_on</i> 
                        <span>{{ count(@peers) }} Peers | {{ @down }} Downloaded Volume | {{ @up }} Uploaded Volume</span>
                    </div>
                </th>
            </tr>
          <tr>
            <th class="mdl-data-table__cell--non-numeric">Address</th>
            <th class="mdl-data-table__cell--non-numeric removeSmall">weight</th>
            <th class="mdl-data-table__cell--non-numeric removeSmall">Downloaded</th>
            <th class="mdl-data-table__cell--non-numeric removeSmall">Uploaded</th>
            <th class="mdl-data-table__cell--non-numeric">Application</th>
            <th class="mdl-data-table__cell--non-numeric">Version</th>
            <th class="mdl-data-table__cell--non-numeric">Platform</th>
          </tr>
        </thead>
        <tbody id="peersTableBody"> 
            <repeat group="{{ @peers }}" value="{{ @peer }}">
                <tr blockId="{{ @peer.ip }}">
                    <td class="mdl-data-table__cell--non-numeric">{{ @peer.announcedAddress }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeSmall">{{ @peer.weight }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeSmall">{{ @peer.downloadedVolume }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeSmall">{{ @peer.uploadedVolume }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @peer.application }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @peer.version }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @peer.platform }}</td>
                </tr>
            </repeat> 
        </tbody>
    </table>
</div>

<!-- ------ Custom Shader Code for atmospheric glow ------ -->
<script id="vertexShaderAtmosphere" type="x-shader/x-vertex">
varying vec3 vNormal;
void main() 
{
    vNormal = normalize( normalMatrix * normal );
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}
</script>

<!-- fragment shader a.k.a. pixel shader -->
<script id="fragmentShaderAtmosphere" type="x-shader/x-vertex"> 
uniform float c;
uniform float p;
varying vec3 vNormal;
void main() 
{
	float intensity = pow( c - dot( vNormal, vec3( 0.0, 0.0, 1.0 ) ), p ); 
	gl_FragColor = vec4( 1.0, 1.0, 1.0, 1.0 ) * intensity;
}
</script>

<script>

    init();

</script>