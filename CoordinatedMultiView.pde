/*
 * Jake Mingolla
 * Dorian Pistilli
 *
 * Fall 2015
 */

import java.util.List;
import java.util.ArrayList;

Integer MARGIN;
Float MARGIN_RATIO = 0.05;

String path = "soe-funding.csv";
List<Data> dataPoints;

Integer topX;
Integer topY;
Integer topW;
Integer topH;

Integer rightX;
Integer rightY;
Integer rightW;
Integer rightH;

Integer leftX;
Integer leftY;
Integer leftW;
Integer leftH;

void setup() {
        fullScreen();
        println(width + " " + height);
        dataPoints = new ArrayList<Data>();
        parse();

        Integer min = (int)min(width, height);
        MARGIN = (int)(min * MARGIN_RATIO);

        topX = MARGIN;
        topY = MARGIN;
        topW = (int)(width - (2 * MARGIN));
        topH = (int)(height/2 - 2*MARGIN);

        leftX = MARGIN;
        leftY = (int)(height/2 + MARGIN);
        leftW = (int)(width/2 - (2*MARGIN));
        leftH = (int)(height/2 - (2*MARGIN));

        rightX = (int)(width/2 + MARGIN);
        rightY = (int)(height/2 + MARGIN);
        rightW = (int)(width/2 - (2*MARGIN));
        rightH = (int)(height/2 - (2*MARGIN));

        for(Data d : dataPoints) {
                println(d.discipline + "," + d.department + "," +
                        d.sponsor + "," + d.year + "," + d.funding);
        }
        println(dataPoints.size());
}

void draw() {
        rect(topX, topY, topW, topH);
        rect(leftX, leftY, leftW, leftH);
        rect(rightX, rightY, rightW, rightH);
}

void parse() {
        String[] fileLines = loadStrings(path);
        String[] currLine;
        for (int i = 1; i < fileLines.length; i++) {
                currLine = split(fileLines[i], ",");
                Data data = new Data();
                data.discipline = currLine[0];
                data.department = currLine[1];
                data.sponsor = currLine[2];
                data.year = parseInt(currLine[3]);
                data.funding = parseInt(currLine[4]);
                dataPoints.add(data);
        }
}
