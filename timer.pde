class Timer {
    private int m_time_start;
    private int m_time_elapsed;
    private boolean state;

    final boolean STATE_RUN = true;
    final boolean STATE_STOP = false;

    Timer() {
        reset();
    }

    void start() {
        m_time_start = millis();
        state = STATE_RUN;
    }

    void pause() {
        m_time_elapsed += millis() - m_time_start;
        m_time_start = 0;
        state = STATE_STOP;
    }

    void reset() {
        m_time_start = 0;
        m_time_elapsed = 0;
        state = STATE_STOP;
    }

    int getTime() {
        if (state == STATE_RUN) {
            return m_time_elapsed + millis() - m_time_start;
        } else {
            return m_time_elapsed;
        }
    }
}
