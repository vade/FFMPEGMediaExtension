//
//  main.m
//  LibAVDebugSanitychecker
//
//  Created by Anton Marini on 7/31/24.
//

#import <Foundation/Foundation.h>
#import <libavformat/avformat.h>

// Function to get the file offset of the first packet of the first stream
void printPacketInfo(const char *filename)
{
    AVFormatContext *formatContext = NULL;
    AVPacket packet;
    int ret;
    int64_t offset = -1;

    // Open the input file
    if (avformat_open_input(&formatContext, filename, NULL, NULL) < 0)
    {
        NSLog(@"Failed to open input file.");
        return;
    }

    formatContext->avio_flags = AVIO_FLAG_DIRECT;
    
    // Find stream information
    if (avformat_find_stream_info(formatContext, NULL) < 0)
    {
        NSLog(@"Failed to find stream info.");
        avformat_close_input(&formatContext);
        return;
    }

    // Read frames until we find the first packet in the first stream
    int i = 0;
    
    while ( (ret = av_read_frame(formatContext, &packet)) >= 0 )
    {
//        avio_flush(formatContext->pb);

        if (packet.stream_index == 0)
        {
            
            // Assuming first stream is index 0
            offset = avio_tell(formatContext->pb) - packet.size;
            
            NSLog(@"Packet %i: offset: %lli: size: %i, pos:%lli  pts:%lli dts: %lli", i, offset, packet.size, packet.pos, packet.pts, packet.dts);
            
            i++;
        }
        av_packet_unref(&packet);
        
    }

    // Handle cases where no packet was found for the first stream
    if (ret < 0) {
        NSLog(@"Failed to read frame or no packet found for the first stream.");
    }

    // Clean up
    avformat_close_input(&formatContext);

}

// Usage example


int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        if (argc < 2)
        {
            NSLog(@"Usage: %s <input file>", argv[0]);
            return 1;
        }
        
        const char *inputFile = argv[1];
        printPacketInfo(inputFile);
        
//        if (offset >= 0)
//        {
//            NSLog(@"Offset of the first packet of the first stream: %" PRId64, offset);
//        }
//        else
//        {
//            NSLog(@"Failed to retrieve the offset.");
//        }
    }
    return 0;
}
