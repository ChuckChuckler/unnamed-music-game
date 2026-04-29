extends AudioStreamPlayer

var spectrumAnalyzer:AudioEffectSpectrumAnalyzerInstance;

const SILENCE_THRESHOLD = -60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spectrumAnalyzer=AudioServer.get_bus_effect_instance(AudioServer.get_bus_index("userInput"),1);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var octaves = ["octave3", "octave4", "octave5", "octave6"];
	var ranges = [[130.813,261,62],[261.63, 523.25], [523.251,1046.501],[1046.502,2093.004]];
	var vols = []
	vols.resize(8)
	vols.fill(-80)
	
	for i in range(0,octaves.size()-1):
		var magn = spectrumAnalyzer.get_magnitude_for_frequency_range(ranges[i][0],ranges[i][1])
		vols[i] = linear_to_db((magn.x+magn.y)/2)
		
	var lowestVol=-INF
	var greatestIndex=0
	
	var octavesDetected = ""
	var volsDetected = ""
	for i in range(vols.size()-1):
		if vols[i]>SILENCE_THRESHOLD:
			#greatestVol=vols[i]
			#greatestIndex=i
			octavesDetected+=octaves[i] + " "
			volsDetected+=str(vols[i])+" "
	if(octavesDetected.length()>0):
		print_debug(octavesDetected)
		print_debug(volsDetected)
	#print_debug(octaves[greatestIndex])
		
	
	
