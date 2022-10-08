#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <QQuickWindow>
#include <QRunnable>
#include <gst/gst.h>
#include <QDebug>

class SetPlaying : public QRunnable {
public:
    SetPlaying(GstElement *);
    ~SetPlaying();

    void run();

private:
    GstElement *pipeline_;
};

SetPlaying::SetPlaying(GstElement *pipeline) {
    this->pipeline_ = pipeline ? static_cast<GstElement *>(gst_object_ref(pipeline)) : NULL;
}

SetPlaying::~SetPlaying() {
    if (this->pipeline_) {
        gst_object_unref(this->pipeline_);
    }
}

void SetPlaying::run() {
    if (this->pipeline_) {
        gst_element_set_state(this->pipeline_, GST_STATE_PLAYING);
    }
}

extern "C" void gst_plug(){
        GST_PLUGIN_STATIC_DECLARE(videotestsrc);
        GST_PLUGIN_STATIC_DECLARE(opengl);
        GST_PLUGIN_STATIC_DECLARE(qmlgl);
        GST_PLUGIN_STATIC_REGISTER(videotestsrc);
        GST_PLUGIN_STATIC_REGISTER(opengl);
        GST_PLUGIN_STATIC_REGISTER(qmlgl);
}

int main(int argc, char *argv[])
{
    gst_plug();
    int ret;
    gst_init(&argc, &argv);
    {
        QGuiApplication app(argc, argv);

        GstElement *pipeline = gst_pipeline_new(NULL);
        GstElement *src = gst_element_factory_make("videotestsrc", NULL);
        GstElement *glupload = gst_element_factory_make("glupload", NULL);

        GstElement *sink = gst_element_factory_make("qmlglsink", NULL);
        if (!sink) {
            qCritical() << "[!] SINK NOT FOUND";
        }
        g_assert(src && glupload && sink);

        gst_bin_add_many(GST_BIN (pipeline), src, glupload, sink, NULL);
        gst_element_link_many(src, glupload, sink, NULL);

        QQmlApplicationEngine engine;
        engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

        QQuickItem *videoItem;
        QQuickWindow *rootObject;
        rootObject = static_cast<QQuickWindow *> (engine.rootObjects().first());
        videoItem = rootObject->findChild<QQuickItem *>("videoItem");
        g_assert(videoItem);
        g_object_set(sink, "widget", videoItem, NULL);

        rootObject->scheduleRenderJob(new SetPlaying(pipeline),
                                      QQuickWindow::BeforeSynchronizingStage);

        ret = app.exec();

        gst_element_set_state(pipeline, GST_STATE_NULL);
        gst_object_unref(pipeline);
    }
    gst_deinit();
    return ret;
}
