//
//  EDDataElementIsisTest.m
//  BARTApplication
//
//  Created by Lydia Hellrung on 5/19/10.
//  Copyright 2010 MPI Cognitive and Human Brain Sciences Leipzig. All rights reserved.
//

#import "EDDataElementIsisTest.h"
#import "EDDataElementIsis.h"


@interface EDDataElementIsisTest (MemberVariables)

	EDDataElementIsis *dataEl;

@end

@implementation EDDataElementIsisTest


-(void) setUp
{
	unsigned int rows = 10;
	unsigned int cols = 21;
	unsigned int slices = 17;
	unsigned int timesteps = 29;
	
	//dataEl = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:rows andCols:cols andSlices:slices andTimesteps:timesteps];
	//for (unsigned int x = 0; x < )
	//[dataEl setVoxelValue:<#(NSNumber *)val#> atRow:<#(int)r#> col:<#(int)c#> slice:<#(int)s#> timestep:<#(int)t#>]
	
	
	//[dataEl WriteDataElementToFile:@""];
	
		dataEl = [[EDDataElementIsis alloc] initWithDatasetFile:@"../tests/BARTMainAppTests/testfiles/TestDataset01-functional.nii" ofImageDataType:IMAGE_DATA_SHORT];
}

-(void)testProperties
{
	STAssertEquals(dataEl.numberCols, (unsigned int)64, @"Incorrect number of columns.");
    STAssertEquals(dataEl.numberRows, (unsigned int)64, @"Incorrect number of rows.");
    STAssertEquals(dataEl.numberTimesteps, (unsigned int)396, @"Incorrect number of timesteps.");
    STAssertEquals(dataEl.numberSlices, (unsigned int)20, @"Incorrect number of slices.");
   // STAssertEquals(dataEl.imageDataType, IMAGE_DATA_SHORT, @"Incorrect image data type.");
}

-(void)testInitWithDatatype
{
	EDDataElementIsis *elem = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:10 andCols:10 andSlices:10 andTimesteps:1];
	
	STAssertNotNil(elem, @"initWithDataType returns nil");
	
	//[elem setVoxelValue:[NSNumber numberWithFloat:2.0] atRow:2 col:2 slice:2 timestep:1];
	STAssertEquals([elem getFloatVoxelValueAtRow:2 col:3 slice:1 timestep:0], (float)0.0, @"set and get voxel value differs");
	
	[elem release];
}

-(void)testImageProperties
{
	
	EDDataElementIsis *elem = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:39 andCols:19 andSlices:2 andTimesteps:190];
	EDDataElementIsis *elemDest = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:19 andCols:29 andSlices:1 andTimesteps:90];
	STAssertNotNil(elem, @"valid init returns nil");
	STAssertNotNil(elemDest, @"valid init returns nil");
	
	// get empty list
	NSArray *propListi = [NSArray arrayWithObjects:nil];
	STAssertEquals([[elem getProps:propListi] count], (NSUInteger) 0, @"empty list for getProps not returning zero size dict");
	STAssertNoThrow([elem setProps:nil], @"empty dict for setProps throws exception");
	
	//strings
	NSString *s1 = @"MyName is bunny";
	NSString *s2 = @"Subject";

	
	NSArray *propList = [NSArray arrayWithObjects:@"prop1",@"prop2", nil];
	NSDictionary *propDictSet = [NSDictionary dictionaryWithObjectsAndKeys:s1, @"prop1", s2, @"prop2", nil];
	STAssertNoThrow([elem setProps:propDictSet], @"");
	STAssertEquals([[elem getProps:propListi] count], (NSUInteger)0, @"empty list for getProps not returning zero sice dict");
	NSDictionary *propDictGet = [elem getProps:propList];
	for (NSString* str in [propDictGet allKeys]){
		STAssertEqualObjects([propDictSet valueForKey:str], [propDictGet valueForKey:str] , @"set and get Props differ");}
	

	// the special ones
	NSArray *readVec = [NSArray arrayWithObjects:[NSNumber numberWithFloat:2.765], [NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:123.76], [NSNumber numberWithFloat:1], nil];
	NSArray *phaseVec = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-0.0], [NSNumber numberWithFloat:-123.986], [NSNumber numberWithFloat:78976.654], [NSNumber numberWithFloat:99.0], nil];
	NSArray *sliceVec = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0], [NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0], [NSNumber numberWithFloat:0], nil];
	NSArray *voxelSize = [NSArray arrayWithObjects:[NSNumber numberWithInt:23], [NSNumber numberWithInt:23.6], [NSNumber numberWithInt:12], [NSNumber numberWithInt:1], nil];
	NSArray *indexOrigin = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-98.0], [NSNumber numberWithFloat:12.0], [NSNumber numberWithFloat:34.9875645], [NSNumber numberWithFloat:0.951], nil];
	NSArray *cppos = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-98.0], [NSNumber numberWithFloat:12.0], [NSNumber numberWithFloat:34.9875645], [NSNumber numberWithFloat:0.951], nil];
	NSArray *capos = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-98.0], [NSNumber numberWithFloat:12.0], [NSNumber numberWithFloat:34.9875645], [NSNumber numberWithFloat:0.951], nil];
	NSArray *voxelGap = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-98.0], [NSNumber numberWithFloat:12.0], [NSNumber numberWithFloat:34.9875645], [NSNumber numberWithFloat:0.951], nil];
	NSNumber *acqNr = [NSNumber numberWithLong:1231];
	NSNumber *seqNr = [NSNumber numberWithInt:11];
	NSNumber *rt = [NSNumber numberWithInt:31];
	NSNumber *sa = [NSNumber numberWithInt:51];
	NSNumber *sw = [NSNumber numberWithInt:91];
	NSNumber *fa = [NSNumber numberWithInt:22];
	NSNumber *na = [NSNumber numberWithInt:66];
	NSNumber *echoTime = [NSNumber numberWithFloat:12.7];
	NSNumber *acqtime = [NSNumber numberWithFloat:11.231];
	
	
	
	NSDictionary *propDictSet2 = [NSDictionary dictionaryWithObjectsAndKeys:s1, @"prop1",
								  s2, @"prop2",
								  readVec, @"readVec", 
								  phaseVec, @"phaseVec", 
								  sliceVec, @"slicevec", 
								  voxelSize, @"voxelSize",
								  indexOrigin, @"indexOrigin", 
								  cppos, @"cppos",
								  capos, @"capos",
								  voxelGap, @"voxelGap", 
								  acqNr, @"acquisitionNumber",
								  seqNr, @"sequenceNumber",
								  rt, @"repetitionTime",
								  sa, @"subjectAge",
								  sw, @"subjectWEIGHT",
								  fa, @"flipAngle",
								  na, @"numberOfAverages",
								  echoTime, @"echoTime",
								  acqtime, @"acquisitionTime",
								  nil];
	
	NSArray *propListGet2 = [NSArray arrayWithObjects:
							 @"numberOfAverages",
							 @"prop2",
							 @"readVec", 
							 @"phaseVec", 
							 @"slicevec", 
							 @"voxelSize",
							 @"indexOrigin", 
							 @"cppos",
							 @"voxelGap", 
							 @"acquisitionNumber",
							 @"sequenceNumber",
							 @"repetitionTime",
							 @"capos",
							 @"subjectAge",
							 @"subjectWEIGHT",
							 @"flipAngle",
							 @"echoTime",
							 @"acquisitionTime",
							 @"prop1",
							 nil];
				
	[elem setProps:propDictSet2];
	NSDictionary *propDictGet2 = [elem getProps:propListGet2];
	for (NSString* str in [propDictGet2 allKeys]){
		STAssertEqualObjects([propDictGet2 valueForKey:str], [propDictSet2 valueForKey:str], [NSString stringWithFormat:@"set and get Props differ for %@", str]);}
	
	
	// not a prop
	NSArray *propListGet3 = [NSArray arrayWithObjects:
							 @"something not defined", nil];
	NSDictionary *propDictGet3 = [elem getProps:propListGet3];
	STAssertEqualObjects([propDictGet3 valueForKey:@"something not defined"], @"", @"not defined prop returns not an empty string");

	// copy from one data element to another one
	
	[elemDest copyProps:propListGet2 fromDataElement:elem];
	NSDictionary *propDictGetDest = [elemDest getProps:propListGet2];
	for (NSString* str in [propDictGetDest allKeys]){
		STAssertEqualObjects([propDictGetDest valueForKey:str], [propDictSet2 valueForKey:str], [NSString stringWithFormat:@"copy Props differ for %@", str]);}
	
	//vectoren länge 1, 5
	NSArray *arrayLength1 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:18.8], nil];
	NSArray *arrayLength5 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.3], [NSNumber numberWithFloat:0.1], 
							 [NSNumber numberWithFloat:0.9], [NSNumber numberWithFloat:19], 
							 [NSNumber numberWithFloat:34], nil];
	
	NSArray *propListGet4 = [NSArray arrayWithObjects:
							 @"indexOrigin", 
							 @"sliceVec", nil];
	
	
	NSDictionary *propDictSet4 = [NSDictionary dictionaryWithObjectsAndKeys:
								  arrayLength1, @"sliceVec", 
								  arrayLength5, @"indexOrigin", nil];
	[elem setProps:propDictSet4];
	
	NSDictionary *propDictGet4 = [elem getProps:propListGet4];
	NSArray *retArrayLength1 = [propDictGet4 valueForKey:@"sliceVec"];
	STAssertEquals([retArrayLength1 count], (NSUInteger)4, @"vector length 1 returns wrong array size");
	STAssertEqualObjects([retArrayLength1 objectAtIndex:0], [arrayLength1 objectAtIndex:0], @"vector length 1 not returning correct value");
	for (uint i = 1; i < 4; i++){
		STAssertEquals([[retArrayLength1 objectAtIndex:i] floatValue], (float) 0, @"vector length 1 not returning 0");}
	
	NSArray *retArrayLength5 = [propDictGet4 valueForKey:@"indexOrigin"];
	STAssertEquals([retArrayLength5 count], (NSUInteger) 4, @"vector length 5 returns wrong array size");
	for (uint i = 1; i < 4; i++){
		STAssertEquals([[retArrayLength5 objectAtIndex:0] floatValue], [[arrayLength5 objectAtIndex:0] floatValue], @"vector length 5 not returning correct value");}
	
	
	[elem release];
	
}
					
-(void)testGetSetVoxelValueAtRow
{
	int nrRows = 37;
	int nrCols = 12;
	int nrSlices = 29;
	int nrTimesteps = 2;
	
	EDDataElementIsis *elem = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:nrRows andCols:nrCols andSlices:nrSlices andTimesteps:nrTimesteps];
	
	NSNumber *voxel1 = [NSNumber numberWithInt:12];
	NSNumber *voxel2 = [NSNumber numberWithFloat:1.6];
	NSNumber *voxel3 = [NSNumber numberWithShort:1223];
	NSNumber *voxel4 = [NSNumber numberWithDouble:1.12312];
		
	//insert at zero and max length
	STAssertNoThrow([elem setVoxelValue:voxel1 atRow:0 col:0 slice:0 timestep:0], @"setVoxelValue throws unexpected exception 1");
	STAssertNoThrow([elem setVoxelValue:voxel2 atRow:nrRows-1 col:7 slice:28 timestep:1], @"setVoxelValue throws unexpected exception 2");
	STAssertNoThrow([elem setVoxelValue:voxel4 atRow:0 col:nrCols-1 slice:0 timestep:0], @"setVoxelValue throws unexpected exception 3");
	STAssertNoThrow([elem setVoxelValue:voxel3 atRow:0 col:0 slice:nrSlices-1 timestep:0], @"setVoxelValue throws unexpected exception 4");
	STAssertNoThrow([elem setVoxelValue:voxel2 atRow:0 col:0 slice:0 timestep:nrTimesteps-1], @"setVoxelValue throws unexpected exception 5");
	STAssertNoThrow([elem setVoxelValue:voxel1 atRow:nrRows-1 col:nrCols-1 slice:nrSlices-1 timestep:nrTimesteps-1], @"setVoxelValue throws unexpected exception 6");
	
	//get from these ones
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:0 slice:0 timestep:0], [voxel1 floatValue], @"getValue does not match expected one 1.");
	STAssertEquals([elem getFloatVoxelValueAtRow:nrRows-1 col:7 slice:28 timestep:1], [voxel2 floatValue], @"getValue does not match expected one 2.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:nrCols-1 slice:0 timestep:0], [voxel4 floatValue], @"getValue does not match expected one 3.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:0 slice:nrSlices-1 timestep:0], [voxel3 floatValue], @"getValue does not match expected one 4.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:0 slice:0 timestep:nrTimesteps-1 ], [voxel2 floatValue], @"getValue does not match expected one 5.");
	STAssertEquals([elem getFloatVoxelValueAtRow:nrRows-1 col:nrCols-1 slice:nrSlices-1 timestep:nrTimesteps-1], [voxel1 floatValue], @"getValue does not match expected one 6.");
	
	
	
	//insert at nonpossible - nothing happens
	STAssertNoThrow([elem setVoxelValue:voxel2 atRow:-1 col:0 slice:0 timestep:0], @"setVoxelValue throws unexpected exception 7");
	STAssertNoThrow([elem setVoxelValue:voxel3 atRow:0 col:-1 slice:0 timestep:0], @"setVoxelValue throws unexpected exception 8");
	STAssertNoThrow([elem setVoxelValue:voxel4 atRow:0 col:0 slice:-1 timestep:0], @"setVoxelValue throws unexpected exception 9");
	STAssertNoThrow([elem setVoxelValue:voxel2 atRow:0 col:0 slice:0 timestep:-1], @"setVoxelValue throws unexpected exception 10");
	STAssertNoThrow([elem setVoxelValue:voxel4 atRow:nrRows col:11 slice:28 timestep:1], @"setVoxelValue throws unexpected exception 11");
	STAssertNoThrow([elem setVoxelValue:voxel2 atRow:0 col:nrCols slice:0 timestep:0], @"setVoxelValue throws unexpected exception 12");
	STAssertNoThrow([elem setVoxelValue:voxel3 atRow:0 col:0 slice:nrSlices timestep:0], @"setVoxelValue throws unexpected exception 13");
	STAssertNoThrow([elem setVoxelValue:voxel1 atRow:0 col:0 slice:0 timestep:nrTimesteps], @"setVoxelValue throws unexpected exception 14");
	
	// get from these impossible ones - should return 0
	STAssertEquals([elem getFloatVoxelValueAtRow:-1 col:0 slice:0 timestep:0], float(0.0), @"getValue does not match expected one 7.");
	STAssertEquals([elem getFloatVoxelValueAtRow:nrRows col:11 slice:28 timestep:1], float(0.0), @"getValue does not match expected one 8.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:nrCols slice:0 timestep:0], float(0.0), @"getValue does not match expected one 9.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:0 slice:nrSlices timestep:0], float(0.0), @"getValue does not match expected one 10.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:0 slice:0 timestep:nrTimesteps ], float(0.0), @"getValue does not match expected one 11.");
	STAssertEquals([elem getFloatVoxelValueAtRow:nrRows col:nrCols slice:nrSlices timestep:nrTimesteps], float(0.0), @"getValue does not match expected one 12.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:-1 slice:0 timestep:0], float(0.0), @"getValue does not match expected one 13.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:0 slice:-1 timestep:0], float(0.0), @"getValue does not match expected one 14.");
	STAssertEquals([elem getFloatVoxelValueAtRow:0 col:0 slice:0 timestep:-1], float(0.0), @"getValue does not match expected one 15.");
	
	
	
	
	[elem release];
	
	
}


-(void)testGetDataFromSlice
{
	uint rows = 13;
	uint cols = 12;
	uint sl = 10;
	uint tsteps = 7;
	EDDataElementIsis *elem = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:rows andCols:cols andSlices:sl andTimesteps:tsteps	];
	for (uint t=0; t < tsteps; t++){
		for (uint s=0; s < sl; s++){
			for (uint c=0; c < cols; c++){
				for (uint r=0; r < rows; r++){
					[elem setVoxelValue:[NSNumber numberWithFloat:r+c+s+t] atRow:r col:c slice:s timestep:t];
				}}}}
	
	//normal case
	uint sliceGet = 3;
	uint tGet = 2;
	float *pSlice = [elem getSliceData:sliceGet	atTimestep:tGet ];
	float* pRun = pSlice;
	for (uint i = 0; i < rows; i++){
		for (uint j = 0; j < cols; j++){
			STAssertEquals((float)*pRun++, (float)sliceGet+tGet+i+j, @"Slice value not as expected");
		}
	}
	free(pSlice);
	
	//first slice
	sliceGet = 0;
	tGet = 6;
	pSlice = [elem getSliceData:sliceGet atTimestep:tGet ];
	pRun = pSlice;
	for (uint i = 0; i < rows; i++){
		for (uint j = 0; j < cols; j++){
			STAssertEquals((float)*pRun++, (float)sliceGet+tGet+i+j, @"Slice value not as expected");
		}
	}
	free(pSlice);
	
	//last slice
	sliceGet = 9;
	tGet = 6;
	pSlice = [elem getSliceData:sliceGet atTimestep:tGet ];
	pRun = pSlice;
	for (uint i = 0; i < rows; i++){
		for (uint j = 0; j < cols; j++){
			STAssertEquals((float)*pRun++, (float)sliceGet+tGet+i+j, @"Slice value not as expected");
		}
	}
	free(pSlice);
		
	//out of size
	sliceGet = 10;
	tGet = 1;
	pSlice = [elem getSliceData:sliceGet atTimestep:tGet ];
	STAssertEquals(pSlice, (float*)NULL, @"Slice pointer on slice out of size not returning NULL");
	
	sliceGet = 2;
	tGet = 8;
	pSlice = [elem getSliceData:sliceGet atTimestep:tGet ];
	STAssertEquals(pSlice, (float*)NULL, @"Slice pointer on timestep out of size not returning NULL");
	
	
	
	
}

-(void)testGetSetRowDataAt
{	
	uint rows = 9;
	uint cols = 13;
	uint sl = 10;
	uint tsteps = 7;
	EDDataElementIsis *elem = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:rows andCols:cols andSlices:sl andTimesteps:tsteps	];
	for (uint t=0; t < tsteps; t++){
		for (uint s=0; s < sl; s++){
			for (uint c=0; c < cols; c++){
				for (uint r=0; r < rows; r++){
					[elem setVoxelValue:[NSNumber numberWithFloat:r+c+s+t] atRow:r col:c slice:s timestep:t];
				}}}}
	
	uint rowGet = 8;
	uint sliceGet = 9;
	uint tGet = 2;
	
	float *pRow = static_cast<float_t *>([elem getRowDataAt:rowGet atSlice:sliceGet atTimestep:tGet]);
	float* pRun = pRow;
	for (uint c=0; c < cols; c++){
		STAssertEquals((float)*pRun++, (float)rowGet+sliceGet+tGet+c, @"Row value not as expected");
	}
	free(pRow);
	
	//************setRowData
	uint rowSet = 6;
	float *dataBuff = static_cast<float_t*> (malloc(sizeof(cols)));
	for (uint i = 0; i < cols; i++){
		dataBuff[i] = 3*i+17;
	}
	[elem setRowAt:rowSet atSlice:sliceGet atTimestep:tGet withData:dataBuff];
	
	pRow = [elem getRowDataAt:rowSet atSlice:sliceGet atTimestep:tGet];
	float* pRowPre = [elem getRowDataAt:rowSet-1 atSlice:sliceGet atTimestep:tGet];
	float* pRowPost = [elem getRowDataAt:rowSet+1 atSlice:sliceGet atTimestep:tGet];
	pRun = pRow;
	float *pRunPre = pRowPre;
	float* pRunPost = pRowPost;
	for (uint c=0; c < cols; c++){
		STAssertEquals((float)*pRun, (float)dataBuff[c], @"Row value not as expected");
		STAssertEquals((float)*pRunPre, (float)(rowSet-1)+sliceGet+tGet+c, @"Pre Row value not as expected");
		STAssertEquals((float)*pRunPost, (float)(rowSet+1)+sliceGet+tGet+c, @"Post Row value not as expected");
		pRun++;pRunPre++;pRunPost++;
	}
	free(pRow);
	free(pRowPre);
	free(pRowPost);
	free(dataBuff);
	
	[elem release];

}

-(void)testGetSetColDataAt
{
	uint rows = 9;
	uint cols = 13;
	uint sl = 10;
	uint tsteps = 7;
	EDDataElementIsis *elem = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:rows andCols:cols andSlices:sl andTimesteps:tsteps	];
	for (uint t=0; t < tsteps; t++){
		for (uint s=0; s < sl; s++){
			for (uint c=0; c < cols; c++){
				for (uint r=0; r < rows; r++){
					[elem setVoxelValue:[NSNumber numberWithFloat:r+c+s+t] atRow:r col:c slice:s timestep:t];
				}}}}

	
	//************getColData
	uint colGet = 11;
	uint sliceGet = 9;
	uint tGet = 2;
	float *pCol = [elem getColDataAt:colGet atSlice:sliceGet atTimestep:tGet];
	float *pRun = pCol;
	for (uint r=0; r < rows; r++){
		STAssertEquals((float)*pRun++, (float)colGet+sliceGet+tGet+r, @"Col value not as expected");
	}
	free(pCol);
	
	uint colSet = 7;
	float *dataBuff2 = static_cast<float_t*> (malloc(sizeof(rows)));
	for (uint i = 0; i < rows; i++){
		dataBuff2[i] = 11+i*17;
	}
	//************setColData
	[elem setColAt:colSet atSlice:sliceGet atTimestep:tGet withData:dataBuff2];
	//	
	pCol = [elem getColDataAt:colSet atSlice:sliceGet atTimestep:tGet];
	float* pColPre = [elem getColDataAt:colSet-1 atSlice:sliceGet atTimestep:tGet];
	float* pColPost = [elem getColDataAt:colSet+1 atSlice:sliceGet atTimestep:tGet];
	pRun = pCol;
	float *pRunPre = pColPre;
	float *pRunPost = pColPost;
	for (uint r=0; r < rows; r++){
		STAssertEquals((float)*pRun++, (float)dataBuff2[r], @"Col value not as expected");
		STAssertEquals((float)*pRunPre++, (float)(colSet-1)+sliceGet+tGet+r, @"Pre Col value not as expected");
		STAssertEquals((float)*pRunPost++, (float)(colSet+1)+sliceGet+tGet+r, @"Post Col value not as expected");
	}
	free(pCol);
	free(pColPre);
	free(pColPost);
	free(dataBuff2);
	
	
	
	
	[elem release];
	
		

}

-(void)testGetTimeSeriesDataAt
{
	uint rows = 17;
	uint cols = 31;
	uint sl = 10;
	uint tsteps = 11;
	EDDataElementIsis *elem = [[EDDataElementIsis alloc] initWithDataType:IMAGE_DATA_FLOAT andRows:rows andCols:cols andSlices:sl andTimesteps:tsteps	];
	for (uint t=0; t < tsteps; t++){
		for (uint s=0; s < sl; s++){
			for (uint c=0; c < cols; c++){
				for (uint r=0; r < rows; r++){
					[elem setVoxelValue:[NSNumber numberWithFloat:r+c+s+t] atRow:r col:c slice:s timestep:t];
				}}}}
	
	
	//************getTimeSeriesData - working case complete
	uint colGet = 16;
	uint rowGet = 12;
	uint sliceGet = 8;
	uint tstart = 0;
	uint tend = 10;
	float *pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	float *pRun = pTimeSeries;
	for (uint t = 0; t < tend-tstart+1; t++){
		STAssertEquals((float)*pRun++, (float)colGet+sliceGet+rowGet+tstart+t, @"Timeseries - working case value not as expected");
	}
	free(pTimeSeries);
	
	//************getTimeSeriesData - working case range
	tstart = 3;
	tend = 7;
	pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	pRun = pTimeSeries;
	for (uint t = 0; t < tend-tstart+1; t++){
		STAssertEquals((float)*pRun++, (float)colGet+sliceGet+rowGet+tstart+t, @"Timeseries - working case range value not as expected");
	}
	free(pTimeSeries);
	//************setTimeSeriesData - limit values
	tstart = 0;
	tend = 1;
	pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	pRun = pTimeSeries;
	for (uint t = 0; t < tend-tstart+1; t++){
		STAssertEquals((float)*pRun++, (float)colGet+sliceGet+rowGet+tstart+t, @"Timeseries - working case range value not as expected");
	}
	free(pTimeSeries);
	tstart = 9;
	tend = 10;
	pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	pRun = pTimeSeries;
	for (uint t = 0; t < tend-tstart+1; t++){
		STAssertEquals((float)*pRun++, (float)colGet+sliceGet+rowGet+tstart+t, @"Timeseries - working case range value not as expected");
	}
	free(pTimeSeries);
	
	//************setTimeSeriesData - out of sizes 
	tstart = 0;
	tend = 0;
	pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	STAssertEquals(pTimeSeries, (float*) NULL,  @"Timeseries - end time equals start time not returning NULL");
	
	tstart = 10;
	tend = 2;
	pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	STAssertEquals(pTimeSeries,(float*) NULL, @"Timeseries - end time earlier start time not returning NULL");
	
	tstart = -2;
	tend = 3;
	pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	STAssertEquals(pTimeSeries, (float*) NULL, @"Timeseries - negative time not returning NULL");
	
	tstart = 0;
	tend = 11;
	pTimeSeries = [elem getTimeseriesDataAtRow:rowGet atCol:colGet atSlice:sliceGet fromTimestep:tstart toTimestep:tend];
	STAssertEquals(pTimeSeries, (float*) NULL, @"Timeseries - end time not matching timesteps not returning NULL");
	
	
	[elem release];

}


-(void)testSliceIsZero
{
//	-(BOOL)sliceIsZero:(int)slice;

}


-(void)testWrite
{
}
//-(void)WriteDataElementToFile:(NSString*)path;









@end