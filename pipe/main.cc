#include <QByteArray>
#include <QString>
#include <stdio.h>
#include <QDebug>


// Tiny popen() test, used for figure out a workaround where
// QProcess() broke "other things".
//
int main(int argc, char **argv) {

	const char* def = "TZ=Europe/Oslo date +'%Z'";
	const char *command;
	if (argc > 1) {
		command = argv[1];
	} else {
		command = def;
	}

	FILE *handle = popen(command, "r");

	if (handle != 0) {

		char buff[100];
		size_t len = fread(buff, sizeof(char), sizeof(buff), handle);
		QByteArray output(buff, len);

		QString result(output);

		qDebug() << result.trimmed();

		fclose(handle);
	} else {
		qDebug() << "ERROR";
	}

	return 0;
}
